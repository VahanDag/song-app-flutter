// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:singer_app/views/author.dart';
import 'package:singer_app/views/my_musics.dart';
import 'package:singer_app/views/popular_musics.dart';
import 'package:singer_app/views/profile.dart';
import 'package:singer_app/views/song_record.dart';

class Routers extends StatefulWidget {
  const Routers({
    super.key,
    this.pageIndex,
  });
  final int? pageIndex;

  @override
  State<Routers> createState() => _RoutersState();
}

class _RoutersState extends State<Routers> {
  final List<IconData> iconList = [
    Icons.library_music_outlined,
    Icons.multitrack_audio_outlined,
    Icons.music_note_outlined,
    Icons.person
  ];
  late final List<Widget> _pages;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PopularMusics(),
      const AuthorPage(),
      const MyMusics(),
      const ProfilePage(),
      SongRecorderPage(
        changedPageIndex: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentPageIndex], //destination screen
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          setState(() {
            _currentPageIndex = _pages.length - 1;
          });
        },
        child: const Icon(
          Icons.mic_none_outlined,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        height: 75,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            iconList[index],
            size: 24,
            color: isActive ? Colors.black : Colors.grey,
          );
        },
        activeIndex: _currentPageIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 40,
        rightCornerRadius: 40,
        onTap: (index) => setState(() => _currentPageIndex = index),
        //other params
      ),
    );
  }
}
