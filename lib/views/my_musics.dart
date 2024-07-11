import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:singer_app/service/cache.dart';
import 'package:singer_app/views/global_widgets.dart';

class MyMusics extends StatefulWidget {
  const MyMusics({super.key});

  @override
  State<MyMusics> createState() => _MyMusicsState();
}

class _MyMusicsState extends State<MyMusics> {
  List<Map<String, dynamic>> _songs = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadSongs() async {
    final songs = await CacheService().getAllSongs();
    if (songs != null) {
      setState(() {
        _songs = songs;
      });
    }
  }

  Future<void> _playRecording(int index) async {
    final filePath = _songs[index]['filePath'];
    if (filePath != null) {
      try {
        if (_currentlyPlayingIndex == index) {
          // Zaten oynatılıyorsa, durdur
          await _audioPlayer.stop();
          setState(() {
            _currentlyPlayingIndex = null;
          });
        } else {
          // Başka bir şarkı oynatılıyorsa durdur
          if (_currentlyPlayingIndex != null) {
            await _audioPlayer.stop();
          }
          await _audioPlayer.play(DeviceFileSource(filePath));
          setState(() {
            _currentlyPlayingIndex = index;
          });
          _audioPlayer.onPlayerComplete.listen((event) {
            setState(() {
              _currentlyPlayingIndex = null;
            });
          });
        }
        print('Playing recording: $filePath');
      } catch (e) {
        print('Error playing recording: $e');
      }
    } else {
      print('No recording file to play');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        imageContainerTop("musics", "müziklerim"),
        (_songs.isNotEmpty)
            ? Expanded(
                child: ListView.builder(
                  itemCount: _songs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(border: Border.all(), borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(_songs[index]['name']),
                        trailing: Icon(_currentlyPlayingIndex == index ? Icons.pause : Icons.play_arrow_rounded),
                        onTap: () {
                          _playRecording(index);
                        },
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: Text("Kayıtlı müzik yok".toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 25)),
              ),
        const SizedBox(height: 40)
      ],
    ));
  }
}
