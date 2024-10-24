import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:watch_flow/data/databases.dart';

import 'package:watch_flow/logic/globalVaribul.dart';
import 'package:watch_flow/logic/shared_preferences.dart';
import 'package:watch_flow/model/playList.dart';

class HelperFunction {
  final Dio _dio = Dio();
  //calculating number of days .
  int calculateNumberOfDays(int duration) {
    int numberOfDays = duration ~/ 86400;
    return numberOfDays;
  }

  // Fetch all videos from a playlist and their details
  Future<List<VideoInfoModel>> getAllVideosInPlaylist(String playlistId) async {
    log("getAllVideosInPlaylist started");
    List<VideoInfoModel> videoDetailsList = [];
    String nextPageToken = '';
    String durationVideo = 'N/A';
    bool hasNextPage = true;
    int start =
        await SharePrefrenceClass().getVlue(key: "start_at", defaultValue: 0);
    int end = 0;
    Map<String, dynamic> insertVideo = {};
    try {
      while (hasNextPage) {
        final response = await _dio.get(
          'https://www.googleapis.com/youtube/v3/playlistItems',
          queryParameters: {
            'part': 'snippet,contentDetails',
            'playlistId': playlistId,
            'maxResults': 50,
            'pageToken': nextPageToken,
            'key': API_KEY,
          },
        );

        final data = response.data;

        final items = data['items'];

        for (var item in items) {
          final videoId = item['contentDetails']['videoId'];
          final title = item['snippet']['title'];
          final description = item['snippet']['description'];
          final thumbnailUrl = item['snippet']['thumbnails']['high']['url'];
          final videoUrl = 'https://www.youtube.com/watch?v=$videoId';

          final duration = await getDurationVideo(videoId);
          durationVideo = duration;
          final videoInfo = VideoInfoModel(
            title: title,
            url: videoUrl,
            description: description,
            id: videoId,
            duration: duration,
            image: thumbnailUrl,
          );
          insertVideo = {
            "video_playlist_id": playlistId,
            "video_tittle": title,
            "video_url": videoUrl,
            "video_image": thumbnailUrl,
            "video_status": 0,
            "video_days": 0,
            "video_duration": durationVideo,
          };

          await DatabaseHelper().insertVideo(insertVideo);
          videoDetailsList.add(videoInfo);
        }

        log(sumTotalTime(videoDetailsList));
        nextPageToken = data['nextPageToken'] ?? '';
        hasNextPage = nextPageToken.isNotEmpty;
      }
      end = start + videoDetailsList.length;
      List<String?> data = await HelperFunction().getPlaylistInfo(playlistId);
      Map<String, dynamic> insertPlaylist = {
        "playlist_id": playlistId,
        "playlist_real_name": data[0],
        "playlist_image": data[2],
        "playlist_total_videos": videoDetailsList.length.toString(),
        "playlist_total_time": sumTotalTime(videoDetailsList).toString(),
        "playlist_notes": "",
        "playlist_start_at": start,
        "playlist_end_at": end,
        "playlist_status": 0,
      };
      await SharePrefrenceClass().saveValueint(value: end, key: "start_at");
      await DatabaseHelper().insertPlaylist(insertPlaylist);
      log(" map is :: $insertPlaylist");
      log('Total videos fetched: ${videoDetailsList.length}');
    } catch (e) {
      log('Error fetching playlist videos: $e');
    }

    return videoDetailsList;
  }

  Future<List<String?>> getPlaylistInfo(String playlistId) async {
    final url =
        'https://www.googleapis.com/youtube/v3/playlists?part=snippet&id=$playlistId&key=$API_KEY';
    List<String?> retun = [];
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        // تحقق مما إذا كانت قائمة التشغيل موجودة
        if (data['items'] != null && data['items'].isNotEmpty) {
          retun.add(data['items'][0]['snippet']['title']);
          retun.add(data['items'][0]['snippet']['description']);
          retun.add(data['items'][0]['snippet']['thumbnails']['high']['url']);

          // استرجاع عنوان قائمة التشغيل
          return retun;
        } else {
          print(
              'No items found in the response. Please check the playlist ID.');
          return [];
        }
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Request failed with error: $e');
      return [];
    }
  }

  // Fetch video duration by ID
  Future<String> getDurationVideo(String videoId) async {
    try {
      final response = await _dio.get(
        'https://www.googleapis.com/youtube/v3/videos',
        queryParameters: {
          'part': 'contentDetails',
          'id': videoId,
          'key': API_KEY,
        },
      );

      final duration = response.data['items'][0]['contentDetails']['duration'];

      return extractDuration(duration);
    } catch (e) {
      log('Error fetching video duration: $e');
      return 'N/A';
    }
  }

  // Helper function to format duration from ISO 8601
  String extractDuration(String duration) {
    final regex = RegExp(r'PT(\d+H)?(\d+M)?(\d+S)?');
    final match = regex.firstMatch(duration);

    if (match != null) {
      final hours = match.group(1) != null
          ? int.parse(match.group(1)!.replaceAll('H', ''))
          : 0;
      final minutes = match.group(2) != null
          ? int.parse(match.group(2)!.replaceAll('M', ''))
          : 0;
      final seconds = match.group(3) != null
          ? int.parse(match.group(3)!.replaceAll('S', ''))
          : 0;

      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    return 'N/A';
  }

  // Calculate total time from a list of video durations
  String sumTotalTime(List<VideoInfoModel> videoList) {
    int totalSeconds = 0;

    for (var video in videoList) {
      final durationParts = video.duration.split(':');
      if (durationParts.length == 3) {
        final hours = int.parse(durationParts[0]);
        final minutes = int.parse(durationParts[1]);
        final seconds = int.parse(durationParts[2]);

        totalSeconds += (hours * 3600) + (minutes * 60) + seconds;
      }
    }

    final totalHours = totalSeconds ~/ 3600;
    totalSeconds %= 3600;
    final totalMinutes = totalSeconds ~/ 60;
    totalSeconds %= 60;

    return '${totalHours.toString().padLeft(2, '0')}:${totalMinutes.toString().padLeft(2, '0')}:${totalSeconds.toString().padLeft(2, '0')}';
  }

  Future<List<String?>> getPlaylistIfoFromDB(String playlistId) async {
    List<Map<String, dynamic>> allInfoPlaylist =
        await DatabaseHelper().getPlaylistById(playlistId);
    log("allInfoPlaylist :: ${allInfoPlaylist[0]['playlist_real_name']}");

    return [];
  }

  Future<List<Map<String, dynamic>>> getALLVideosINPlaylistIfoFromDB(
      String playlistId) async {
    List<Map<String, dynamic>> allInfoPlaylist =
        await DatabaseHelper().getVideosByPlaylistId(playlistId);
    // log("allInfoPlaylist :: ${allInfoPlaylist.length.toString()}");
    return allInfoPlaylist;
  }

  int timeToMinutes(String time) {
    // Split the time string into hours, minutes, and seconds
    List<String> parts = time.split(':');

    // Parse hours, minutes, and seconds
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    // Convert hours to minutes
    int totalMinutes = hours * 60 + minutes;

    // Convert seconds to minutes and add them
    totalMinutes += seconds ~/ 60;

    return totalMinutes;
  }

  Future<String> extractJsonFromText(String text) async {
    // البحث عن بداية ونهاية الجزء اللي بيحتوي على الـ JSON
    int startIndex = text.indexOf('```json');
    int endIndex = text.lastIndexOf('```');
    // التأكد إن تم العثور على الجزء الصحيح
    if (startIndex == -1 || endIndex == -1 || startIndex >= endIndex) {
      throw Exception('Failed to extract JSON');
    }
    // استخراج الـ JSON من النص
    String jsonPart = text.substring(startIndex + 7, endIndex).trim();
    // إعادة النص مباشرة كـ String
    return jsonPart;
  }
}
