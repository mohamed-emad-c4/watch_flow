import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:watch_flow/logic/ai_response/ai.dart';
import 'package:watch_flow/logic/helper.dart';
import 'package:watch_flow/generated/l10n.dart';
import '../../../data/databases.dart';
import '../../../logic/cubit/update_home_cubit.dart';
import '../../../logic/globalVaribul.dart';
import '../../../model/playList.dart';

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

  String curentMessage = ''; // Declare curentMessage as a state variable

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).please_enter_a_URL;
    }
    if (!value.contains('youtube.com/playlist?list=')) {
      return S.of(context).please_enter_a_valid_youtube_playlist_URL;
    }
    return null;
  }

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
      curentMessage = "Starting the insertion process...";
      _isLoading = true;
    });

    List<VideoInfoModel> getAllVideosInPlaylistD = [];
    try {
      String url = _urlController.text.trim();
      String notes = _notesController.text.trim();
      String time = _timeController.text.trim();

      String playlistId = _extractPlaylistId(url);

      if (playlistId.isEmpty) {
        _showSnackbar(S.of(context).invalid_playlist_url);
        setState(() {
          curentMessage = "Check your playlist URL ......";
          _isLoading = false;
        });
        return;
      }

      setState(() {
        curentMessage = "Checking if playlist exists...";
      });

      bool playlistExists = await DatabaseHelper().isPlaylistExists(playlistId);
      if (playlistExists) {
        Get.snackbar(
          "✖️ Playlist already exists ✖️",
          "Please add another playlist",
          colorText: Colors.white,
          backgroundColor: Colors.red.shade500,
        );
        setState(() {
          curentMessage = "Error: Playlist already exists";
          _isLoading = false;
        });
        return;
      }

      setState(() {
        curentMessage = "Fetching videos from the playlist...";
      });

      getAllVideosInPlaylistD =
          await HelperFunction().getAllVideosInPlaylist(playlistId, notes);

      if (getAllVideosInPlaylistD.isEmpty) {
        Get.snackbar(
          "✖️ Playlist not found ✖️",
          "Please add another playlist link",
          colorText: Colors.white,
          backgroundColor: Colors.red.shade500,
        );
        setState(() {
          curentMessage = "Error: Playlist not found";
          _isLoading = false;
        });
        return;
      }

      setState(() {
        curentMessage = "Processing AI response...";
      });

      await GiminiAi().aiResponse(
          int.parse(time) + (int.parse(time) * 0.25).toInt(), playlistId);

      Get.snackbar(
        "✔️ Playlist added ✔️",
        "Done",
        colorText: Colors.white,
        backgroundColor: Colors.green.shade500,
      );

      setState(() {
        curentMessage = "Done";
        _isLoading = false;
      });

      BlocProvider.of<UpdateHomeCubit>(context).updateHome();
      Navigator.pop(context, true);
    } catch (e, stackTrace) {
      _showSnackbar('${S.of(context).error}: $e');
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      setState(() {
        curentMessage = "An error occurred: $e";
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
      ),
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).add_Playlist),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildInputField(
                  controller: _urlController,
                  labelText: S.of(context).playlist_url,
                  hintText: S.of(context).enter_the_URL_of_the_playlist,
                  validator: _validateUrl,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _timeController,
                  labelText: S.of(context).time,
                  hintText: S.of(context).enter_time_in_minutes,
                  validator: _validateTime,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _notesController,
                  labelText: S.of(context).notes,
                  hintText: S.of(context).enter_any_notes_about_the_playlist,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _insertPlaylist,
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
                ),
                if (_isLoading)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const Center(child: CircularProgressIndicator()),
                      if (curentMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            curentMessage,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
