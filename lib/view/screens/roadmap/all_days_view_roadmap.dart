import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_flow/generated/l10n.dart';

final List<Map<String, dynamic>> daysAndVideos = [
  {
    "day": 1,
    "videos": [
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 1. Hello Visual Studio",
        "duration": "00:13:04",
        "url": "https://www.youtube.com/watch?v=Y8c1IHZs5qc",
        "learning_video_task":
            "Introduction to Visual Basic.NET and Visual Studio IDE."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 2. Customise The Visual Studio IDE",
        "duration": "00:05:30",
        "url": "https://www.youtube.com/watch?v=HbU3msDuif8",
        "learning_video_task":
            "Customizing the Visual Studio IDE for better workflow."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginners Lesson 3. Output and Variables",
        "duration": "00:15:14",
        "url": "https://www.youtube.com/watch?v=N7nw2jjnCnQ",
        "learning_video_task":
            "Understanding basic output and variable concepts in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 4. Variable Data Types",
        "duration": "00:07:31",
        "url": "https://www.youtube.com/watch?v=XM3mXeTrSeE",
        "learning_video_task":
            "Exploring different data types for variables in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 5. Input with Windows Forms",
        "duration": "00:12:23",
        "url": "https://www.youtube.com/watch?v=6ZRM6T24uR0",
        "learning_video_task":
            "Taking input from users through Windows Forms in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 6. Debugging Code",
        "duration": "00:08:29",
        "url": "https://www.youtube.com/watch?v=EceKLMxzE_8",
        "learning_video_task":
            "Learning how to debug code effectively in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 7. Arithmetic Operators",
        "duration": "00:11:37",
        "url": "https://www.youtube.com/watch?v=wUeraOAfw9A",
        "learning_video_task":
            "Understanding arithmetic operators and their usage in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 8. Complex Arithmetic Expressions",
        "duration": "00:08:26",
        "url": "https://www.youtube.com/watch?v=PB_3vwgGXGo",
        "learning_video_task":
            "Working with complex arithmetic expressions in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 9. Selection with If Statements",
        "duration": "00:10:09",
        "url": "https://www.youtube.com/watch?v=4R1vniYOP44",
        "learning_video_task":
            "Introduction to conditional statements (If) in Visual Basic.NET."
      }
    ],
    "total_duration": "01:17:41",
    "learning_task":
        "Fundamentals of Visual Basic.NET - setting up environment, basic syntax, variables, data types, input/output, and debugging. "
  },
  {
    "day": 2,
    "videos": [
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 10. Logical and Relational Operators 1",
        "duration": "00:14:34",
        "url": "https://www.youtube.com/watch?v=BRjDnqLXZPY",
        "learning_video_task": "Logical and Relational Operators Part 1."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 11. Logical and Relational Operators 2",
        "duration": "00:09:06",
        "url": "https://www.youtube.com/watch?v=dV-dOuGNDlE",
        "learning_video_task": "Logical and Relational Operators Part 2."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 12. Select Case",
        "duration": "00:06:20",
        "url": "https://www.youtube.com/watch?v=1EdExr_oojM",
        "learning_video_task":
            "Understanding and using the Select Case statement."
      },
      {
        "title": "Visual Basic.NET Programming. Beginner Lesson 13. For Next",
        "duration": "00:05:20",
        "url": "https://www.youtube.com/watch?v=7X_w_XHGe10",
        "learning_video_task":
            "Introduction to loop structures - For Next loop."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 14. Practice For Next Loops & If Blocks",
        "duration": "00:04:23",
        "url": "https://www.youtube.com/watch?v=9It2PcyA6kM",
        "learning_video_task": "Practicing For Next loops and If statements."
      },
      {
        "title": "Visual Basic.NET Programming. Beginner Lesson 15. Do While",
        "duration": "00:08:46",
        "url": "https://www.youtube.com/watch?v=8kKed0YsKm4",
        "learning_video_task": "Understanding and using Do While loop."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 16. Condition Controlled Loops",
        "duration": "00:08:16",
        "url": "https://www.youtube.com/watch?v=ofyFQtMU5Hk",
        "learning_video_task": "Conditional control of loops."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 17. Array Variables",
        "duration": "00:10:09",
        "url": "https://www.youtube.com/watch?v=V4-So9cvq_k",
        "learning_video_task": "Introduction to Arrays in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 18. Practice Arrays & Loops",
        "duration": "00:09:59",
        "url": "https://www.youtube.com/watch?v=ihTp5ZC8W-o",
        "learning_video_task": "Practice using arrays and loops together."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 19. Linear Search",
        "duration": "00:06:38",
        "url": "https://www.youtube.com/watch?v=HHHgnoQoThc",
        "learning_video_task": "Implementing a linear search algorithm."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 20. Two Dimensional Arrays",
        "duration": "00:10:37",
        "url": "https://www.youtube.com/watch?v=5uO2-KdZ3-I",
        "learning_video_task":
            "Understanding and using 2D arrays in Visual Basic.NET."
      },
      {
        "title":
            "Visual Basic.NET Programming. Beginner Lesson 21. 2D Arrays & Nested Loops",
        "duration": "00:10:19",
        "url": "https://www.youtube.com/watch?v=Kkm4CEFbF08",
        "learning_video_task": "Combining 2D arrays with nested loops."
      }
    ],
    "total_duration": "01:41:41",
    "learning_task":
        "Control flow structures (loops and conditional statements), array manipulation, and algorithm implementation (linear search)."
  }
];

class AllDaysRoadmap extends StatefulWidget {
  const AllDaysRoadmap({super.key});

  @override
  _AllDaysRoadmapState createState() => _AllDaysRoadmapState();
}

class _AllDaysRoadmapState extends State<AllDaysRoadmap> {
  late List<bool> expandedDays;

  @override
  void initState() {
    super.initState();
    expandedDays = List.generate(daysAndVideos.length, (index) => false);
  }

  void toggleDay(int index) {
    setState(() {
      expandedDays[index] = !expandedDays[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Building AllDaysRoadmap");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).all_days_roadmap),
      ),
      body: ListView.builder(
        itemCount: daysAndVideos.length,
        itemBuilder: (context, index) {
          log("Building DaySection for index: $index");
          final dayData = daysAndVideos[index];
          return DaySection(
            day: "${dayData['day']}",
            videos: List<Map<String, dynamic>>.from(
                dayData['videos'] as List<Map<String, dynamic>>),
            totalDuration: dayData['total_duration'] as String,
            learningTask: dayData['learning_task'] as String,
            isExpanded: expandedDays[index],
            onTap: () => toggleDay(index),
          );
        },
      ),
    );
  }
}

class DaySection extends StatelessWidget {
  final String day;
  final List<Map<String, dynamic>> videos;
  final String totalDuration;
  final String learningTask;
  final bool isExpanded;
  final VoidCallback onTap;

  const DaySection({
    super.key,
    required this.day,
    required this.videos,
    required this.totalDuration,
    required this.learningTask,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    log("Building DaySection for day: $day");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.expand_more),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          child: isExpanded
              ? Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return VideoCard(
                          video: video['title'],
                          duration: video['duration'],
                          url: video['url'],
                          learningTask: video['learning_video_task'],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Duration: $totalDuration",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Learning Task: $learningTask",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
        ),
        const Divider(
          height: 8,
          thickness: 2,
          color: Colors.grey,
        ),
      ],
    );
  }
}
// To open YouTube link

class VideoCard extends StatelessWidget {
  final String video;
  final String duration;
  final String url;
  final String learningTask;

  const VideoCard({
    super.key,
    required this.video,
    required this.duration,
    required this.url,
    required this.learningTask,
  });

  // Method to open video URL in YouTube app or browser
  void _openVideo(BuildContext context, String url) async {
    final Uri videoUri = Uri.parse(url);
    if (await canLaunchUrl(videoUri)) {
      await launchUrl(videoUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the video.")),
      );
    }
  }

  // Method to show the task details in a dialog
  void _showTaskDialog(BuildContext context, String task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Learning Task"),
        content: Text(task),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Method to handle video marking logic (e.g., marking as complete)
  void _markVideo(BuildContext context) {
    // Placeholder for the mark video logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Video marked!")),
    );
  }

  // Method to summarize the video (placeholder functionality)
  void _summarizeVideo(BuildContext context) {
    // Placeholder for the summarize functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Summary of the video: Coming soon!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Optionally handle tap to view video details
      },
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail of the video
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://img.youtube.com/vi/${Uri.parse(url).queryParameters['v']}/0.jpg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey,
                          child: const Center(
                            child: Icon(Icons.error, color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.play_circle_outline,
                          color: Colors.white, size: 40),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Video info and action icons
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${S.of(context).duration}: $duration",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${S.of(context).task}: $learningTask",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Action buttons
              Column(
                children: [
                  IconButton(
                    tooltip: 'Show Task',
                    icon: const Icon(Icons.text_snippet_outlined),
                    onPressed: () => _showTaskDialog(context, learningTask),
                  ),
                  IconButton(
                    tooltip: 'Open in YouTube',
                    icon: const Icon(Icons.ondemand_video),
                    onPressed: () => _openVideo(context, url),
                  ),
                  IconButton(
                    tooltip: 'Mark Video',
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: () => _markVideo(context),
                  ),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
