import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/playList.dart';
import '../view/screens/roadmap/all_days_view_roadmap.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'playlist_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE playlist_info(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        playlist_id TEXT NOT NULL,
        playlist_real_name TEXT,
        playlist_notes TEXT,
        playlist_url TEXT,
        playlist_total_time TEXT,
        playlist_total_videos TEXT,
        playlist_start_at INTEGER,
        playlist_image TEXT,
        playlist_end_at INTEGER,
        playlist_status INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE videos_info(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
         TEXT NOT NULL,
        video_url TEXT,
        video_image TEXT,
        video_duration TEXT,
        learning_task TEXT,
        video_status BOOLEAN,
        video_days INTEGER,
        video_playlist_id TEXT,
        FOREIGN KEY (video_playlist_id) REFERENCES playlist_info (playlist_id)
      )
    ''');
  }

  // CRUD operations for playlist_info

  Future<int> insertPlaylist(Map<String, dynamic> playlist) async {
    Database db = await database;
    return await db.insert('playlist_info', playlist);
  }

  Future<List<Map<String, dynamic>>> getPlaylists() async {
    Database db = await database;
    return await db.query('playlist_info');
  }

  Future<List<Map<String, dynamic>>> getPlaylistById(String playlistId) async {
    Database db = await database;
    return await db.query('playlist_info',
        where: 'playlist_id = ?', whereArgs: [playlistId]);
  }

  Future<int> updatePlaylist(Map<String, dynamic> playlist) async {
    Database db = await database;
    return await db.update(
      'playlist_info',
      playlist,
      where: 'id = ?',
      whereArgs: [playlist['id']],
    );
  }

  Future<int> deletePlaylist(int id) async {
    Database db = await database;
    return await db.delete('playlist_info', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for videos_info

  Future<int> insertVideo(Map<String, dynamic> video) async {
    Database db = await database;
    return await db.insert('videos_info', video);
  }

  Future<List<Map<String, dynamic>>> getVideos() async {
    Database db = await database;
    return await db.query('videos_info');
  }

  Future<List<Map<String, dynamic>>> getVideosByPlaylistId(
      String playlistId) async {
    Database db = await database;
    return await db.query('videos_info',
        where: 'video_playlist_id = ?', whereArgs: [playlistId]);
  }

  Future<List<Video>> getVideosByPlaylistIdAI(String playlistId) async {
    final db = await database;

    // جلب الفيديوهات من قاعدة البيانات
    final List<Map<String, dynamic>> maps = await db.query(
      'videos_info',
      where: 'video_playlist_id = ?',
      whereArgs: [playlistId],
    );

    // تحويل النتيجة إلى قائمة من الفيديوهات مع تضمين حالة is_done
    return List.generate(maps.length, (i) {
      return Video(
        videoId:
            maps[i]['video_id'] ?? '', // إذا كان null، استبدله بسلسلة فارغة
        videoTitle: maps[i]['video_tittle'] ?? '',
        videoImage: maps[i]['video_image'] ?? '',
        videoUrl: maps[i]['video_url'] ?? '',
        videoDuration: maps[i]['video_duration'] ?? '',
        videoDays: maps[i]['video_days'] ?? 0, // توفير قيمة افتراضية للأرقام
        learningTask: maps[i]['learning_task'] ?? '',
        isDone: maps[i]['video_status'] == 1, // التعامل مع الحقل كقيمة منطقية
      );
    });
  }

  Future<int> updateVideo(Map<String, dynamic> video) async {
    Database db = await database;
    return await db.update(
      'videos_info',
      video,
      where: 'video_url = ?',
      whereArgs: [video['id']],
    );
  }

  Future<int> deleteVideo(int id) async {
    Database db = await database;
    return await db.delete('videos_info', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateVideoDaysByUrl(
      String videoUrl, int newDays, String learningVideoTask) async {
    Database db = await database;
    return await db.update(
      'videos_info',
      {
        'video_days': newDays,
        "learning_task": learningVideoTask
      }, // تحديث فقط video_days
      where: 'video_url = ?', // استخدام URL الفيديو كمعيار للتحديث
      whereArgs: [videoUrl], // تمرير URL الفيديو
    );
  }

  Future<void> toggleVideoStatus(String videoUrl, bool currentStatus) async {
    Database db = await database;

    // قلب الحالة الحالية للفيديو
    bool newStatus = !currentStatus;

    // تحديث الحالة الجديدة للفيديو في قاعدة البيانات
    await db.update(
      'videos_info',
      {
        'video_status': newStatus ? 1 : 0
      }, // تحديث العمود is_done بناءً على الحالة الجديدة
      where: 'video_url = ?',
      whereArgs: [videoUrl],
    );
  }
}
