import 'package:flutter/material.dart';

class FAQExpantionTileextends extends StatelessWidget {
  const FAQExpantionTileextends({
    super.key,
    required this.title,
    required this.body,
  });
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(body),
        ),
      ],
    );
  }
}
