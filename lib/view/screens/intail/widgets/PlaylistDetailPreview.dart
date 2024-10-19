/* --- Begin lib\view\screens\intail\widgets\PlaylistDetailPreview.dart --- */
import 'package:flutter/material.dart';
import 'package:watch_flow/generated/l10n.dart';
import '../../../../model/playList.dart';

class PlaylistPreviewAll extends StatelessWidget {
  final PlaylistPreview playlist;

  const PlaylistPreviewAll({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            playlist.playlistImage,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlist.playlistRealName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${S.of(context).total_Videos}: ${playlist.playlistTotalVideos}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${S.of(context).url}: ${playlist.playlistTotalTime}',
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
    );
  }
}
/* --- End lib\view\screens\intail\widgets\PlaylistDetailPreview.dart --- */