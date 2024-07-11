// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:singer_app/core/custom_button.dart';
import 'package:singer_app/service/cache.dart';
import 'package:singer_app/views/global_widgets.dart';

class SongRecorderPage extends StatefulWidget {
  const SongRecorderPage({
    super.key,
    this.changedPageIndex,
  });

  final Function(int index)? changedPageIndex;
  @override
  _SongRecorderPageState createState() => _SongRecorderPageState();
}

class _SongRecorderPageState extends State<SongRecorderPage> {
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _filePath;
  final TextEditingController _songNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    final storageStatus = await Permission.storage.request();
    if (status != PermissionStatus.granted || storageStatus != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone or storage permission not granted');
    }
    await _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      _filePath = '${dir.path}/${Random().nextInt(50) + 250}.aac';
      await _recorder!.startRecorder(toFile: _filePath, codec: Codec.aacADTS);
      setState(() {
        _isRecording = true;
      });
      print('Recording started: $_filePath');
    } catch (e) {
      print('Failed to start recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      print('Recording stopped: $_filePath');

      // Dosyanın varlığını kontrol et
      if (await File(_filePath!).exists()) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    "Şarkına bir isim ver",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        final songName = _songNameController.text.trim();
                        if (songName.isNotEmpty) {
                          final cacheService = CacheService();
                          final songs = await cacheService.getAllSongs() ?? [];
                          songs.add({"name": songName, "filePath": _filePath});
                          await cacheService.saveSongs(songs);
                        }
                        Navigator.pop(context);
                        widget.changedPageIndex?.call(2);
                      },
                      child: const Text("Şarkıyı kaydet"))
                ],
                content: SizedBox(
                  height: 300,
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Lottie.asset(height: 150, "assets/lottie/save-song.json"),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(border: Border.all(width: 1.5), borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Şarkı ismi",
                            ),
                            controller: _songNameController,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
        print('Recording file exists: $_filePath');
      } else {
        print('Recording file does not exist: $_filePath');
      }
    } catch (e) {
      print('Failed to stop recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              imageContainerTop("music2", "şarkı söyle"),
              const SizedBox(height: 100),
              _isRecording ? Lottie.asset(height: 250, "assets/lottie/sing-record.json") : const SizedBox.shrink(),
              const SizedBox(height: 50),
              CustomButton(
                  icon: const Icon(
                    Icons.multitrack_audio_outlined,
                    color: Colors.white,
                  ),
                  title: _isRecording ? 'Kaydı Durdur' : 'Kaydı Başlat',
                  onTap: _isRecording ? _stopRecording : _startRecording),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}
