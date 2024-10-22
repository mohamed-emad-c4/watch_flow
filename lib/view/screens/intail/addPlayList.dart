import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_flow/logic/ai_response/ai.dart';
import 'package:watch_flow/logic/helper.dart';
import 'package:watch_flow/generated/l10n.dart';
import '../../../logic/cubit/update_home_cubit.dart';

class PlaylistInputScreen extends StatefulWidget {
  const PlaylistInputScreen({super.key});

  @override
  _PlaylistInputScreenState createState() => _PlaylistInputScreenState();
}

class _PlaylistInputScreenState extends State<PlaylistInputScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_a_URL;
    }
    if (!value.contains('youtube.com/playlist?list=')) {
      return S.of(context).please_enter_a_valid_youtube_playlist_URL;
    }
    return null;
  }

  String time = "60 ";
  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_time;
    }
    int? time = int.tryParse(value);
    if (time == null || time <= 0) {
      return S.of(context).please_enter_a_valid_time;
    }
    return null;
  }

  Future<void> _insertPlaylist() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String url = _urlController.text.trim();
      String notes = _notesController.text.trim();
      time = _timeController.text.trim();

      String playlistId = _extractPlaylistId(url);

      if (playlistId.isEmpty) {
        _showSnackbar(S.of(context).invalid_playlist_url);
        return;
      }

      await HelperFunction().getAllVideosInPlaylist(playlistId);

      BlocProvider.of<UpdateHomeCubit>(context).updateHome();
      Navigator.pop(context, true);
    } catch (e) {
      _showSnackbar('${S.of(context).error}: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _extractPlaylistId(String url) {
    RegExp regExp = RegExp(r'list=([a-zA-Z0-9_-]+)');
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).add_Playlist),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildUrlInputField(),
              const SizedBox(height: 20),
              _buildTimeInputField(),
              const SizedBox(height: 20),
              _buildNotesInputField(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await GiminiAi()
              .aiResponse(120, "PL88kafUXXgBaAgb0h3-ZMvzxb5J2qFrut");
        },
        child: const Icon(Icons.close),
      ),
    );
  }

  Widget _buildUrlInputField() {
    return TextFormField(
      controller: _urlController,
      decoration: InputDecoration(
        labelText: S.of(context).playlist_url,
        hintText: S.of(context).enter_the_URL_of_the_playlist,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: _validateUrl,
    );
  }

  Widget _buildTimeInputField() {
    return TextFormField(
      controller: _timeController,
      decoration: InputDecoration(
        labelText: S.of(context).time,
        hintText: S.of(context).enter_time_in_minutes,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: TextInputType.number,
      validator: _validateTime,
    );
  }

  Widget _buildNotesInputField() {
    return TextFormField(
      controller: _notesController,
      decoration: InputDecoration(
        labelText: S.of(context).notes,
        hintText: S.of(context).enter_any_notes_about_the_playlist,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      maxLines: 3,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _insertPlaylist,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.grey[800],
      ),
      child: Text(
        S.of(context).insert,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
