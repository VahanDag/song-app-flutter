import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:singer_app/views/global_widgets.dart';

class PopularMusics extends StatefulWidget {
  const PopularMusics({super.key});

  @override
  State<PopularMusics> createState() => PopularMusicsState();
}

class PopularMusicsState extends State<PopularMusics> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  final List<Map<String, String>> _popularSongs = [
    {"name": "Aşka Gel", "singer": "Aydilge", "filePath": "musics/Aydilge - Aşka Gel.mp3"},
    {"name": "Sana Doğru", "singer": "Bora Duran", "filePath": "musics/Bora Duran - Sana Doğru.mp3"},
    {"name": "Sar Bu Şehri", "singer": "Can Ozan", "filePath": "musics/Can Ozan - Sar Bu Şehri.mp3"},
    {"name": "Whoopty (Robert Cristian Remix)", "singer": "CJ", "filePath": "musics/CJ - Whoopty.mp3"},
    {
      "name": "Ruhumda Sızı",
      "singer": "Ender Balkır",
      "filePath": "musics/Ender Balkır - Ruhumda Sızı [ Çukur Dizi Şarkısı].mp3"
    },
    {
      "name": "Summertime Sadness",
      "singer": "Lana Del Rey",
      "filePath": "musics/Lana Del Rey - Summertime Sadness (Official Audio).mp3"
    },
    {
      "name": "pembe mezarlık (slowed + reverb)",
      "singer": "model",
      "filePath": "musics/model - pembe mezarlık (slowed + reverb).mp3"
    },
    {
      "name": "Another Love (Official Video)",
      "singer": "Tom Odell",
      "filePath": "musics/Tom Odell - Another Love (Official Video).mp3"
    },
    {"name": "Stan", "singer": "Dido", "filePath": "musics/Dido Stan Loop intro.mp3"},
    {"name": "ax u eman", "singer": "evin", "filePath": "musics/evin ax u eman.mp3"},
    {"name": "Bu Akşam", "singer": "duman", "filePath": "musics/duman_bu_aksam_mp3_76896.mp3"},
    {"name": "Gündoğdu Marşı", "singer": "Grup Yorum", "filePath": "musics/Grup Yorum - Gündoğdu Marşı (1).mp3"},
    {"name": "Dünyanın Sonunda Doğmuşum", "singer": "maNga", "filePath": "musics/maNga - Dünyanın Sonunda Doğmuşum.mp3"},
    {"name": "Bu Havada Gidilmez", "singer": "Manuş Baba", "filePath": "musics/Manuş Baba - Bu Havada Gidilmez.mp3"},
    {
      "name": "Gül ki Sevgilim (Akustik)",
      "singer": "Oğuzhan Koç",
      "filePath": "musics/Oğuzhan Koç - Gül ki Sevgilim (Akustik).mp3"
    },
    {"name": "Sözlerimi Geri Alamam", "singer": "Norm Ender", "filePath": "musics/Norm Ender - Sözlerimi Geri Alamam.mp3"},
    {
      "name": "Kusura Bakma (Official Music Video)",
      "singer": "Tuğkan",
      "filePath": "musics/Tuğkan - Kusura Bakma (Official Music Video).mp3"
    },
    {
      "name": "nalan (cover)",
      "singer": "emir can iğrek",
      "filePath": "musics/emir can iğrek - nalan (cover) ayça özefe.mp3"
    },
    {"name": "Hayrane", "singer": "", "filePath": "musics/Hayrane.mp3"},
    {
      "name": "Haberin Var Mı (Official Audio)",
      "singer": "Manuş Baba",
      "filePath": "musics/Manuş Baba - Haberin Var Mı (Official Audio).mp3"
    },
    {"name": "dansöz", "singer": "serdar ortaç", "filePath": "musics/serdar_ortac_dansoz_official_music_uploaded.mp3"},
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _totalDuration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _currentPosition = p;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPauseSong(int index) async {
    final song = _popularSongs[index];
    if (_currentlyPlayingIndex == index) {
      await _audioPlayer.pause();
      setState(() {
        _currentlyPlayingIndex = null;
      });
    } else {
      if (_currentlyPlayingIndex != null) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(AssetSource(song['filePath']!));
      setState(() {
        _currentlyPlayingIndex = index;
      });
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _currentlyPlayingIndex = null;
        });
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            imageContainerTop("musics", "popüler müzikler"),
            Expanded(
              child: ListView.builder(
                itemCount: _popularSongs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(15),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.music_note_outlined),
                            trailing: Icon(
                              _currentlyPlayingIndex == index ? Icons.pause : Icons.play_arrow,
                            ),
                            title: Text(_popularSongs[index]['name']!),
                            subtitle: Text(_popularSongs[index]['singer']!),
                            onTap: () {
                              _playPauseSong(index);
                            },
                          ),
                          if (_currentlyPlayingIndex == index)
                            Column(
                              children: [
                                Slider(
                                  value: _currentPosition.inSeconds.toDouble(),
                                  max: _totalDuration.inSeconds.toDouble(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _audioPlayer.seek(Duration(seconds: value.toInt()));
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_formatDuration(_currentPosition)),
                                    Text(_formatDuration(_totalDuration)),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
