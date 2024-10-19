import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../intail/widgets/roadmap_videos_listview.dart';

class RoadmapView extends StatelessWidget {
  RoadmapView({super.key});
  bool isDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Day Num.n Roadmap'),
        ),
        body: Expanded(
            child: roadmap_videos_listview(
          isDone: isDone,
          onTap: () {},
          videoImage: 'assets/images/lan.png',
          title: S.of(context).video,
          duration: S.of(context).duration,
        )));
  }
}
