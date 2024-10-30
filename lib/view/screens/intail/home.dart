import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:watch_flow/generated/l10n.dart';
import 'package:watch_flow/logic/cubit/update_home_cubit.dart';
import 'package:watch_flow/view/VideoPreviewScreen.dart';
import 'package:watch_flow/view/screens/intail/addPlayList.dart';
import 'package:watch_flow/view/screens/roadmap/all_days_view_roadmap.dart';
import 'package:watch_flow/view/settings.dart';

import '../../../data/databases.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateHomeCubit(),
      child: BlocBuilder<UpdateHomeCubit, UpdateHomeState>(
        builder: (context, state) {
          if (state is UpdateHomeLoaded || state is UpdateHomeInitial) {
            return const PlaylistScreen();
          } else if (state is UpdateHomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UpdateHomeError) {
            return Center(child: Text(S.of(context).error));
          } else {
            return Center(child: Text(S.of(context).something_went_wrong));
          }
        },
      ),
    );
  }
}

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late Future<List<Map<String, dynamic>>> playlists;

  @override
  void initState() {
    super.initState();
    playlists = DatabaseHelper().getPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(S.of(context).all_Playlists),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Setting()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: playlists,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('${S.of(context).error}: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(S.of(context).no_playlists_found));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          itemBuilder: (context, index) {
            final playlist = snapshot.data![index];

            return _buildPlaylistItem(context, playlist);
          },
        );
      },
    );
  }

  Widget _buildPlaylistItem(
      BuildContext context, Map<String, dynamic> playlist) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context, playlist);
      },
      child: LayoutBuilder(
  builder: (context, constraints) {
    final bool isLargeScreen = constraints.maxWidth > 800; // Define large screen threshold
    final imageHeight = isLargeScreen ? 200.0 : 150.0;
    final imageWidth = isLargeScreen ? constraints.maxWidth * 0.4 : double.infinity;
    final fontSizeTitle = isLargeScreen ? 22.0 : 18.0;
    final fontSizeSubtitle = isLargeScreen ? 16.0 : 14.0;
    final cardPadding = isLargeScreen ? const EdgeInsets.all(24.0) : const EdgeInsets.all(16.0);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: cardPadding,
        child: isLargeScreen
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section for large screens
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      imageUrl: playlist['playlist_image'] ?? 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      height: imageHeight,
                      width: imageWidth,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between image and text
                  // Text content for large screens
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist['playlist_real_name'] ?? S.of(context).notitle,
                          style: TextStyle(
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${S.of(context).total_Videos}: ${playlist['playlist_total_videos'] ?? 0}    ${S.of(context).total_Time}: ${playlist['playlist_total_time'] ?? 0}",
                          style: TextStyle(
                            fontSize: fontSizeSubtitle,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section for small screens
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                    child: CachedNetworkImage(
                      imageUrl: playlist['playlist_image'] ?? 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      height: imageHeight,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          playlist['playlist_real_name'] ?? S.of(context).notitle,
                          style: TextStyle(
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${S.of(context).total_Videos}: ${playlist['playlist_total_videos'] ?? 0}    ${S.of(context).total_Time}: ${playlist['playlist_total_time'] ?? 0}",
                          style: TextStyle(
                            fontSize: fontSizeSubtitle,
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
  },
)

    );
  }

  void _showBottomSheet(BuildContext context, Map<String, dynamic> playlist) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_play),
              title: Text(S.of(context).view_Playlist),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPreviewScreen(
                      playlistId: playlist['playlist_id'],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_run),
              title: Text(S.of(context).view_Playlist_Roadmap),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyApp1(playlistId: playlist['playlist_id']),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text(S.of(context).delete_playlist),
              onTap: () {
                Navigator.pop(context);
                _deletePlaylist(context, playlist['playlist_id']);
              },
            )
          ],
        ),
      ),
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }

  void _deletePlaylist(BuildContext context, String playlistId) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).confirm_delete),
        content:
            Text(S.of(context).are_you_sure_you_want_to_delete_this_playlist),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(S.of(context).cancle),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(S.of(context).delete),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      try {
        await DatabaseHelper().deletePlaylist(playlistId);
        setState(() {
          playlists = DatabaseHelper().getPlaylists(); // Refresh playlists
        });
        Get.snackbar(
          S.of(context).success,
          S.of(context).playlist_deleted_successfully,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context).error}: $e')),
        );
      }
    }
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlaylistInputScreen(),
          ),
        );

        if (result == true) {
          setState(() {
            playlists = DatabaseHelper().getPlaylists(); // Refresh playlists
          });
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
