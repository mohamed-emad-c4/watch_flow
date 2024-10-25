import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      throw 'Error fetching videos: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Playlist'),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add settings button action
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Video>>(
        future: _videosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No videos found.'));
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
        throw 'Could not launch $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
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
                    child: Image.network(
                      widget.video.videoImage,
                      width: imageWidth,
                      height: 80,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
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
                          'Duration: ${widget.video.videoDuration}',
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
                    tooltip: 'Open Video',
                  ),
                  IconButton(
                    icon: const Icon(Icons.book, color: Colors.orange),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Learning Task'),
                            content: Text(widget.video.learningTask),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    tooltip: 'View Learning Task',
                  ),
                  IconButton(
                    icon: Icon(
                      widget.video.isDone
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: widget.video.isDone ? Colors.green : Colors.grey,
                    ),
                    onPressed: _markAsDone,
                    tooltip: 'Mark as Done',
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Day $day',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dayVideos.length,
              itemBuilder: (context, index) {
                return VideoCard(video: dayVideos[index]);
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 32,
            ),
          ],
        );
      },
    );
  }
}
