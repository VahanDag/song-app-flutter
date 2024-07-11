import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:singer_app/service/cache.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CacheService _service = CacheService();
  String _userName = "İsim girilmedi";
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _userName = await _service.getUsername() ?? "İsim girilmedi";
    _profileImagePath = await _service.getProfileImage();

    setState(() {});
  }

  Future<void> _saveUserName(String userName) async {
    await _service.saveUserName(userName);
    setState(() {
      _userName = userName;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';
      final imageFile = File(pickedFile.path);
      await imageFile.copy(imagePath);

      await _service.saveProfileImage(imagePath);

      setState(() {
        _profileImagePath = imagePath;
      });
    }
  }

  void _changeUserName() {
    final TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("İsim değiştir"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Yeni isim girin"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  _saveUserName(newName);
                }
                Navigator.pop(context);
              },
              child: const Text("Kaydet"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 125,
              width: 125,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                image: _profileImagePath != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(_profileImagePath!)),
                      )
                    : const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/musics.png"),
                      ),
              ),
              child: _profileImagePath == null ? const Icon(Icons.person) : null,
            ),
            Card(
              child: Container(
                width: 250,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Text(
                  _userName.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _pickImage,
              label: const Text("Resmi değiştir"),
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
            ),
            TextButton.icon(
              onPressed: _changeUserName,
              label: const Text("İsim değiştir"),
              icon: const Icon(
                Icons.person,
                size: 20,
              ),
            ),
            const SizedBox(height: 50),
            Lottie.asset(height: 150, "assets/lottie/save-song.json"),
          ],
        ),
      ),
    );
  }
}
