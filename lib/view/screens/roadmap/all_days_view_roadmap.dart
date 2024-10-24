import 'package:flutter/material.dart';

import '../../../data/databases.dart';

class MyApp1 extends StatefulWidget {
  String playlistId ;
   MyApp1({super.key ,required this.playlistId});

  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  List<Video> videos = [
    // Add more videos here...
  ];

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    videos = await DatabaseHelper()
        .getVideosByPlaylistIdAI("${widget.playlistId}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VideoScreen(videos: videos);
  }
}

class Video {
  final int id;
  final String videoTitle;
  final String videoUrl;
  final String videoImage;
  final String videoDuration;
  final int videoStatus;
  final int videoDays;
  final String videoPlaylistId;

  Video({
    required this.id,
    required this.videoTitle,
    required this.videoUrl,
    required this.videoImage,
    required this.videoDuration,
    required this.videoStatus,
    required this.videoDays,
    required this.videoPlaylistId,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      videoTitle: json['video_tittle'],
      videoUrl: json['video_url'],
      videoImage: json['video_image'],
      videoDuration: json['video_duration'],
      videoStatus: json['video_status'],
      videoDays: json['video_days'],
      videoPlaylistId: json['video_playlist_id'],
    );
  }
}

class VideoCard extends StatelessWidget {
  final Video video;

  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              video.videoImage,
              width: 120,
              height: 80,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.videoTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Duration: ${video.videoDuration}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Playlist'),
      ),
      body: ListView.builder(
        itemCount: groupedVideos.length,
        itemBuilder: (context, index) {
          int day = groupedVideos.keys.elementAt(index);
          List<Video> dayVideos = groupedVideos[day]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Day $day',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
            ],
          );
        },
      ),
    );
  }
}
