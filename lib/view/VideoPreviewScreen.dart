import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
    log("playlistAllVideos: ${playlistAllVideos}");
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
              ? const Center(child: Text('No videos found'))
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
                            child: Image.network(
                              video['video_image'],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
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
                                  'Duration: ${video['video_duration']}  ${video['video_days']}',
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
                                        final url = video['video_url'];
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: const Text(
                                        'Watch Video',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    Text(
                                      video['video_status'] == 1
                                          ? 'Completed'
                                          : 'Pending',
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
