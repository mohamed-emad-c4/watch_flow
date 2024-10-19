import 'package:flutter/material.dart';

class roadmap_videos_listview extends StatelessWidget {
  const roadmap_videos_listview({
    super.key,
    required this.isDone,
    required this.onTap,
    required this.videoImage,
    required this.title,
    required this.duration,
  });

  final bool isDone;
  final VoidCallback onTap;
  final String videoImage;
  final String title;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: onTap,
              child: Card(
                color: isDone == true ? Colors.green : Colors.grey[200],
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4, // Add shadow for a modern look
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          videoImage,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$title ${index + 1}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "$duration ${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.double_arrow_rounded, color: Colors.grey[700]),
                    ],
                  ),
                ),
              ),
            );
          }
    );
  }
}
