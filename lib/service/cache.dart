import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<List<Map<String, dynamic>>?> getAllSongs() async {
    final prefs = await SharedPreferences.getInstance();
    final songsJson = prefs.getString('songs');
    if (songsJson != null) {
      final List<dynamic> songsList = jsonDecode(songsJson);

      return songsList.cast<Map<String, dynamic>>();
    }
    return null;
  }

  Future<void> saveSongs(List<Map<String, dynamic>> songs) async {
    final prefs = await SharedPreferences.getInstance();
    final songsJson = jsonEncode(songs);
    await prefs.setString('songs', songsJson);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('userName');
  }

  Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('profileImagePath');
  }

  Future<void> saveUserName(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
  }

  Future<void> saveProfileImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('profileImagePath', imagePath);
  }
}
