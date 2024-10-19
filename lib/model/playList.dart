/* --- Begin lib\model\playList.dart --- */
class VideoInfoModel {
  final String title;
  final String url;
  final String description;
  final String id;
  final String duration;
  final String image;
  
  VideoInfoModel({
    required this.title,
    required this.url,
    required this.description,
    required this.id,
    required this.duration,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'description': description,
      'id': id,
      'duration': duration,
      'image': image,
    };
  }

  static VideoInfoModel fromMap(Map<String, dynamic> map) {
    return VideoInfoModel(
      title: map['title'],
      url: map['url'],
      description: map['description'],
      id: map['id'],
      duration: map['duration'],
      image: map['image'],
    );
  }
}

class PlaylistPreview {
  final int id;
  final String playlistId;
  final String playlistRealName;
  final String playlistNotes;
  final String? playlistUrl;
  final String playlistImage;
  final String playlistTotalTime;
  final int playlistTotalVideos;
  final int playlistStartAt;
  final int playlistEndAt;
  final int playlistStatus;

  PlaylistPreview({
    required this.id,
    required this.playlistId,
    required this.playlistRealName,
    required this.playlistNotes,
    this.playlistUrl,
    required this.playlistImage,
    required this.playlistTotalTime,
    required this.playlistTotalVideos,
    required this.playlistStartAt,
    required this.playlistEndAt,
    required this.playlistStatus,
  });

  static PlaylistPreview fromMap(Map<String, dynamic> map) {
    return PlaylistPreview(
      id: map['id'],
      playlistId: map['playlist_id'],
      playlistRealName: map['playlist_real_name'],
      playlistNotes: map['playlist_notes'],
      playlistUrl: map['playlist_url'],
      playlistImage: map['playlist_image'],
      playlistTotalTime: map['playlist_total_time'],
      playlistTotalVideos: map['playlist_total_videos'],
      playlistStartAt: map['playlist_start_at'],
      playlistEndAt: map['playlist_end_at'],
      playlistStatus: map['playlist_status'],
    );
  }
}
/* --- End lib\model\playList.dart --- */