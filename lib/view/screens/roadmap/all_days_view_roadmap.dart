import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_flow/generated/l10n.dart';

import '../../../data/databases.dart';
import '../../../model/playList.dart';

class MyApp1 extends StatefulWidget {
  final String playlistId;

  const MyApp1({super.key, required this.playlistId});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  late Future<List<Video>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _videosFuture = fetchVideos();
  }

  Future<List<Video>> fetchVideos() async {
    try {
      return await DatabaseHelper().getVideosByPlaylistIdAI(widget.playlistId);
    } catch (e) {
      throw '${S.of(context).error}: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).all_Videos,
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Video>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(S.of(context).no_videos_found));
          } else {
            return VideoScreen(videos: snapshot.data!);
          }
        },
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final Video video;

  const VideoCard({super.key, required this.video});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool isDone = false;

  void _markAsDone() async {
    try {
      // استدعاء toggleVideoStatus لتبديل الحالة في قاعدة البيانات
      await DatabaseHelper().toggleVideoStatus(widget.video.videoUrl, isDone);

      // تحديث واجهة المستخدم بعد نجاح العملية
      setState(() {
        isDone = !isDone;
      });

      // تحديث حالة الفيديو نفسها
      widget.video.isDone = isDone;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error toggling video status: $e')),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw '${S.of(context).could_not_launch} $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).could_not_launch}: $e')),
      );
    }
  }

  Future<void> _updateVideoStatus() async {
    try {
      await DatabaseHelper().updateVideoDaysByUrl(
        widget.video.videoUrl,
        widget.video.videoDays,
        widget.video.learningTask,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating video status: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isDone = widget.video.isDone;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;
    final imageWidth = screenWidth * 0.3;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: cardWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.video.videoImage,
                        width: imageWidth,
                        height: 80,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                            child:
                                CircularProgressIndicator()), // يظهر أثناء التحميل
                        errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red), // يظهر عند حدوث خطأ
                      )),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.video.videoTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${S.of(context).duration}: ${widget.video.videoDuration}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.open_in_new, color: Colors.blue),
                    onPressed: () => _launchUrl(widget.video.videoUrl),
                    tooltip: S.of(context).open_video,
                  ),
                  IconButton(
                    icon: const Icon(Icons.book, color: Colors.orange),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(S.of(context).learinig_task),
                            content: Text(widget.video.learningTask),
                            actions: <Widget>[
                              TextButton(
                                child: Text(S.of(context).ok),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    tooltip: S.of(context).learinig_task,
                  ),
                  IconButton(
                    icon: Icon(
                      widget.video.isDone
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: widget.video.isDone ? Colors.green : Colors.grey,
                    ),
                    onPressed: _markAsDone,
                    tooltip: S.of(context).mark_as_done,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoScreen extends StatelessWidget {
  final List<Video> videos;

  const VideoScreen({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    // Group videos by video_days
    Map<int, List<Video>> groupedVideos = {};
    for (var video in videos) {
      if (!groupedVideos.containsKey(video.videoDays)) {
        groupedVideos[video.videoDays] = [];
      }
      groupedVideos[video.videoDays]!.add(video);
    }

    return ListView.builder(
      itemCount: groupedVideos.length,
      itemBuilder: (context, index) {
        int day = groupedVideos.keys.elementAt(index);
        List<Video> dayVideos = groupedVideos[day]!;

        return ExpansionTile(
          title: Text(
            '${S.of(context).day} $day (${dayVideos.length} ${S.of(context).videos})',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          children: dayVideos.map((video) => VideoCard(video: video)).toList(),
        );
      },
    );
  }
}
