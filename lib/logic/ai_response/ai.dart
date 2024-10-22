import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import '../../data/databases.dart';
import '../helper.dart';

const String giminiAiApiKey = "AIzaSyCLPtP-PRbk5R11EUZbpYdM1USwPRyHj5o";

class GiminiAi {
  List<Map<String, dynamic>> playlistInfo = [];
  List<Map<String, dynamic>> allInfoPlaylist = [];

  Future<void> aiResponse(int durationOfDay, String playlistId) async {
    try {
      log("Started AI Response for playlist ID: $playlistId");

      // Fetch playlist and video information
      await _fetchPlaylistInfo(playlistId);
      await _fetchAllVideos(playlistId);

      // Check for empty data
      if (playlistInfo.isEmpty || allInfoPlaylist.isEmpty) {
        log("No data found for playlist ID: $playlistId");
        return;
      }

      // Construct the list of videos with titles and durations
      String allVideos = _constructVideosList();

      // Initialize the generative model
      final model = GenerativeModel(
        model: 'gemini-1.5-pro-002',
        apiKey: giminiAiApiKey,
      );

      // Extract total time and total videos from the playlist info
      String totalTime = playlistInfo[0]['playlist_total_time'];
      String totalVideos = playlistInfo[0]['playlist_total_videos'];
      int numberDays = _calculateNumberOfDays(totalTime, durationOfDay);
      log("Number of Days: $numberDays, Duration per Day: $durationOfDay");

      // Construct the prompt for the generative AI
      String prompt = _createPrompt(
          numberDays, durationOfDay, totalVideos, totalTime, allVideos);

      // Generate content using the generative model
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      log("AI Response: ${response.text}");
      // Extract and parse the JSON response
      String jsonPart = _extractJsonPart(response.text.toString());
      if (jsonPart.isEmpty) {
        log("Failed to extract JSON part from the response.");
        return;
      }

      var decodedData = jsonDecode(jsonPart);
      log("Decoded Data: $decodedData");
    } catch (e, stackTrace) {
      log("Error in aiResponse: $e", error: e, stackTrace: stackTrace);
    }
  }

  Future<void> _fetchPlaylistInfo(String playlistId) async {
    playlistInfo = await DatabaseHelper().getPlaylistById(playlistId);
    if (playlistInfo.isEmpty) {
      log("Playlist not found in the database.");
    }
  }

  Future<void> _fetchAllVideos(String playlistId) async {
    allInfoPlaylist =
        await HelperFunction().getALLVideosINPlaylistIfoFromDB(playlistId);
    if (allInfoPlaylist.isEmpty) {
      log("No videos found in the playlist.");
    }
  }

  String _constructVideosList() {
    return allInfoPlaylist.asMap().entries.map((entry) {
      var video = entry.value;
      return "${entry.key + 1}. ${video['video_tittle']}, ${video['video_duration']} ${video['video_url']}";
    }).join('\n');
  }

  int _calculateNumberOfDays(String totalTime, int durationOfDay) {
    return (HelperFunction().timeToMinutes(totalTime) ~/ durationOfDay) + 1;
  }

  String _createPrompt(int numberDays, int durationOfDay, String totalVideos,
      String totalTime, String allVideos) {
    return """
I am a mobile app developer working on a project using the Gemini API. You are an expert with 20 years of experience in creating educational roadmaps for online teaching.

Task:
- Analyze the total duration of the playlist and create a structured learning plan.
- Ensure that if any video exceeds $durationOfDay minutes, it should be split across days.

### Input:
- *Playlist Information*: The playlist will be provided as a structured input, including:
  - *Title*: "video Title"
  - *Total Videos*: $totalVideos
  - *Total Duration*: $totalTime (in HH:MM)
  - *All Videos*: A list of videos with each video's title, duration (in HH:MM), and URL.
  - **If video is longer than ($durationOfDay) minutes, split it into the next day.**
  - *If video duration is not specified, assume it is 1 hour.*

### Instructions:
1. *Duration Analysis*: 
   - Distribute the videos evenly over approximately $numberDays days to closely match the ($durationOfDay) minutes target.
   - Ensure that daily video durations are as evenly distributed as possible across approximately $numberDays days.
  
2. *Daily Breakdown*: 
   - For each day, provide a breakdown that includes:
     - *Video Details*: Title, duration, and URL for each video.
     - *Total Duration*: Sum of video durations for the day.
     - *Learning Goal*: Summarize the learning objectives or tasks for that day based on the content.
  
3. *Output Format*:
   - Return the response in JSON format, formatted to be directly inserted into a database.
   - Ensure that each video’s URL is returned in the format: "https://www.youtube.com/watch?v=xxxxxxxxxx".

Example Response (JSON Format):
[
  {
    "day": 1,
    "videos": [
      {
        "title": "Introduction to HTML",
        "duration": "time",
        "url": "https://www.youtube.com/watch?v=xxxxxxxxxx",
        "learning_video_task": "Learn the basics of HTML and its syntax."
      },
      {
        "title": "HTML Tags",
        "duration": "1time",
        "url": "https://www.youtube.com/watch?v=xxxxxxxxxx",
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
        "url": "https://www.youtube.com/watch?v=xxxxxxxxxx",
        "learning_video_task": "Learn the basics of CSS and its syntax."
      }
    ],
    "total_duration": "time",
    "learning_task": "Learn to style HTML using CSS."
  }
]
""";
  }

  String _extractJsonPart(String text) {
    final jsonPattern = RegExp(r'(\{[\s\S]*?\})');
    var match = jsonPattern.firstMatch(text);
    if (match != null) {
      String jsonString = match.group(0)!.trim();
      try {
        // Validate JSON to catch potential issues before returning
        jsonDecode(jsonString);
        return jsonString;
      } catch (e) {
        log("JSON decoding error: $e. JSON String: $jsonString");
        return "";
      }
    } else {
      log("No valid JSON found in the response.");
      return "";
    }
  }
}
