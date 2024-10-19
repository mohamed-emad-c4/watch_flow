import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:watch_flow/generated/l10n.dart';
import 'package:watch_flow/logic/cubit/update_home_cubit.dart';
import 'package:watch_flow/view/screens/intail/addPlayList.dart';
import 'package:watch_flow/view/screens/roadmap/all_days_view_roadmap.dart';

import '../../../data/databases.dart';
import '../../VideoPreviewScreen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateHomeCubit, UpdateHomeState>(
      builder: (context, state) {
        if (state is UpdateHomeLoaded || state is UpdateHomeInitial) {
          return const PlaylistScreen();
        } else if (state is UpdateHomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UpdateHomeError) {
          return Center(child: Text('${S.of(context).error}: '));
        } else {
          return Center(child: Text('${S.of(context).something_went_wrong} '));
        }
      },
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
      appBar: AppBar(
        title: Text(S.of(context).all_Playlists),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Toggle dark mode
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllDaysRoadmap()));
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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

              return GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
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
                                  builder: (context) => const AllDaysRoadmap(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
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
                },
                child: Hero(
                  tag: 'playlistHero-${playlist['playlist_id']}',
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12.0)),
                          child: Stack(
                            children: [
                              Image.network(
                                playlist['playlist_image'] ??
                                    'https://via.placeholder.com/150',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Tooltip(
                                    message: playlist['playlist_real_name'] ??
                                        'No Title',
                                    child: Text(
                                      playlist['playlist_real_name'] ??
                                          'No Title',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${S.of(context).total_Videos}: ${playlist['playlist_total_videos'] ?? 0}    ${S.of(context).total_Time}: ${playlist['playlist_total_time'] ?? 0}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlaylistInputScreen(),
            ),
          );

          if (result == true) {
            setState(() {
              playlists = DatabaseHelper().getPlaylists(); // refresh playlists
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
