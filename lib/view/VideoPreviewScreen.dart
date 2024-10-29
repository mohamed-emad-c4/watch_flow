import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_flow/generated/l10n.dart';
import '../data/databases.dart';

class VideoPreviewScreen extends StatefulWidget {
  final String playlistId;
  late List<Map<String, dynamic>> allInfoPlaylist;

  VideoPreviewScreen({super.key, required this.playlistId});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  List<Map<String, dynamic>> playlistAllVideos = [];
  bool _isLoading = true;
  bool _isPlaylistInfoLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
    getPlaylistInfo();
  }

  Future<void> getPlaylistInfo() async {
    final playlist = await DatabaseHelper().getPlaylistById(widget.playlistId);
    setState(() {
      widget.allInfoPlaylist = playlist;
      _isPlaylistInfoLoaded = true;
    });
  }

  Future<void> _fetchVideos() async {
    playlistAllVideos =
        await DatabaseHelper().getVideosByPlaylistId(widget.playlistId);
    log("playlistAllVideos: $playlistAllVideos");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isPlaylistInfoLoaded
              ? '${widget.allInfoPlaylist.isNotEmpty ? widget.allInfoPlaylist[0]['playlist_real_name'] : 'Playlist'}'
              : 'Loading...',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading || !_isPlaylistInfoLoaded
          ? const Center(child: CircularProgressIndicator())
          : playlistAllVideos.isEmpty
              ? Center(child: Text(S.of(context).no_videos_found))
              : ListView.builder(
                  itemCount: playlistAllVideos.length,
                  itemBuilder: (context, index) {
                    final video = playlistAllVideos[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: video['video_image'],
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child:
                                        CircularProgressIndicator()), // يظهر أثناء التحميل
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error,
                                        color: Colors.red), // يظهر عند حدوث خطأ
                              )),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video['video_tittle'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  '${S.of(context).duration}: ${video['video_duration']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        final url =
                                            Uri.parse(video['video_url']);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    '${S.of(context).could_not_launch} $url')),
                                          );
                                        }
                                      },
                                      child: Text(
                                        S.of(context).watch_video,
                                        style:
                                            const TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    Text(
                                      video['video_status'] == 1
                                          ? S.of(context).completed
                                          : S.of(context).pending,
                                      style: TextStyle(
                                        color: video['video_status'] == 1
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
