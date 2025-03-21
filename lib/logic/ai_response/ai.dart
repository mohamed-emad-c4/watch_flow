import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../data/databases.dart';
import '../globalVaribul.dart';
import '../helper.dart';

const String giminiAiApiKey = "AIzaSyCLPtP-PRbk5R11EUZbpYdM1USwPRyHj5o";
Map<String, dynamic> handledByAi = {};

class GiminiAi {
  List<Map<String, dynamic>> playlistInfo = [];
  List<Map<String, dynamic>> allInfoPlaylist = [];

  Future<void> aiResponse(int durationOfDay, String playlistId) async {
     CurentMessage = " AI request started ...";
    int numberDays = 0;
    try {
      log("started aiResponse");
      // Fetch playlist information from the database
      playlistInfo = await DatabaseHelper().getPlaylistById(playlistId);
      if (playlistInfo.isEmpty) {
        log("Playlist not found in the database.");
        return;
      }

      // Fetch all videos in the playlist from the database
      allInfoPlaylist =
          await HelperFunction().getALLVideosINPlaylistIfoFromDB(playlistId);
      if (allInfoPlaylist.isEmpty) {
        log("No videos found in the playlist.");
        return;
      }

      // Construct the list of videos with their titles and durations
      String allVideos = "";
      int videoIndex = 1;
      for (var video in allInfoPlaylist) {
        allVideos +=
            "$videoIndex. ${video['video_tittle']}, ${video["video_duration"]} ${video["video_url"]} \n";
        videoIndex++;
      }

      // Initialize the generative model
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: giminiAiApiKey,
      );

      // Extract total time and total videos from the playlist info
      String totalTime = playlistInfo[0]['playlist_total_time'];
      String totalVideos = playlistInfo[0]["playlist_total_videos"];
      numberDays =
          (HelperFunction().timeToMinutes(totalTime) ~/ durationOfDay) + 1;
      log("numberDays :: $numberDays :: $durationOfDay ::  HelperFunction().timeToMinutes(totalTime) :: ${HelperFunction().timeToMinutes(totalTime)}");
      // Construct the prompt for the generative AI
      String prompt = """

I am a mobile app developer working on a project using the Gemini API. You are an expert with 20 years of experience in creating educational roadmaps for online teaching.
remember aproximately in $numberDays days and the total duration is approximately $totalTime minutes and minimum of ${durationOfDay * 0.95} minutes per day  and maximum of ${durationOfDay * 1.3} minutes per day.

Task:
- Analyze the total duration of the playlist and create a structured learning plan.
- Ensure that if any video exceeds $durationOfDay minutes, it should be split across days.
every day approximately ($durationOfDay) minutes of video content.
I need you to create a structured video learning plan from a YouTube playlist. The goal is to distribute approximately ($durationOfDay) minutes of video content per day. You will:
### Input:
- Playlist Information: The playlist will be provided as a structured input, including:
  - Title: "video Title"
  - Total Videos: $totalVideos (e.g., 15)
  - Total Duration: $totalTime (in HH:MM, e.g., 25:52 hours)
  - All Videos: A list of videos with each video's title, duration (in HH:MM), and URL.
  - Learning Goal: A summary of the learning goals and tasks for each day.
  -** if video is longer than ($durationOfDay) minutes part it in next day.**
  - if video duration is not specified, assume it is 1 hour.
### Instructions:
1. Duration Analysis: 
   - Analyze the playlist's total duration and destribute it over aproximately $numberDays days. Each day should aim for close to ($durationOfDay) minutes of video content.
   - Ensure that daily video durations are as evenly distributed as possible across aproximately $numberDays days.
  
2. Daily Breakdown: 
   - For each day, provide a breakdown that includes:
     - Video Details: Title, duration, and URL for each video.
     - Total Duration: Sum of video durations for the day.
     - Learning Goal: Summarize the learning objectives or tasks for that day based on the content.
  
3. Output Format:
   
Playlist Information:
The playlist includes the following details:

Title: "تعلم HTML من الصفر: كورس تعلم تطوير وتصميم المواقع وبرمجة صفحات الويب بالعربي"
Duration: 5:52 (example)
URL: https://www.youtube.com/watch?v=xxxxxxxxxx
Total Videos: $totalVideos
Total Duration: $totalTime
Here is the full playlist:
$allVideos

Instructions:
1. Distribute the videos evenly over aproximately the $numberDays days to closely match the ($durationOfDay) minutes target.
2. Summarize the key information for each day's videos (title, duration, URL).
3. Provide a brief learning task or goal description for each day based on the video content.
4. Return the response in JSON format, formatted to be directly inserted into a database.
5. Specify which day each video belongs to.
6. Ensure that each video’s URL is returned in the format: "https://www.youtube.com/watch?v=xxxxxxxxxx".
7.Summarize the key information for each  videos .
8. do not send anything i dont mention it to you .
Example Response (JSON Format):

[
  {
    "day": 1,
    "videos": [
      {
        "title": "Introduction to HTML",
        "duration": "time",
        "url": "https://www.youtube.com/watch?v=xxxxxxxxxx"
        "learning_video_task": "Learn the basics of HTML and its syntax."
      },
      {
        "title": "HTML Tags",
        "duration": "1time",
        "url": "https://www.youtube.com/watch?v=xxxxxxxxxx"
        "learning_task": "Understand the basic structure of HTML and its various tags."
      }
    ],
    "total_duration": "time",
    "learning_task": "Understand basic HTML structure and essential tags."
  },
  {
    "day": 2,
    "videos": [
      {
        "title": "CSS Basics",
        "duration": "time",
        "url": "https://www.youtube.com/watch?v=xxxxxxxxxx"
        "learning_video_task": "Learn the basics of CSS and its syntax."
      }
    ],
    "total_duration": "time",
    "learning_task": "Learn to style HTML using CSS."
  }
]
remember aproximately in $numberDays days and the total duration is approximately $totalTime minutes and minimum of ${durationOfDay * 0.95} minutes per day and maximum of ${durationOfDay * 1.3} minutes per day.
- Analyze the total duration of the playlist and create a structured learning plan.
- Ensure that if any video exceeds $durationOfDay minutes, it should be split across days.
""";
      //  log(prompt);
      // log("$totalVideos \n $totalTime   \n $numberDays \n $durationOfDay ");
      // Generate content using the generative model
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // Extract and parse the JSON response
      String text = response.text.toString();
      //log("text: $text");
      try {
        String extractedJson = await HelperFunction().extractJsonFromText(text);
        log("extractedJson: $extractedJson");
        List<dynamic> jsonData = jsonDecode(extractedJson);
        int i = 0;
        for (var item in jsonData) {
          // log("day: ${item['day']}");
          // log("total_duration: ${item['total_duration']}");
          for (var element in item['videos']) {
            int result = await DatabaseHelper().updateVideoDaysByUrl(
                element["url"],
                item['day'],
                element["learning_video_task"] ?? "not set");

           // log(' $i Updated rows count: ${element["url"]} ${item['day']}${element["title"]} , ${element["learning_video_task"]}');
            //log(' $i Updated rows count: $result');
            i++;
          }
        
        }
        CurentMessage = " Done updating video days in DB ...";
      } catch (e) {
        log("Error in aiResponse: $e");
        print(e); // في حالة وجود خطأ
      }
    } catch (e) {
      log("Error in aiResponse: $e");
    }
  }
  
}
