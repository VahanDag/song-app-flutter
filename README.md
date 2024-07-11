
# Music Player App

<p align="center">
  <img src="https://github.com/VahanDag/song-app-flutter/blob/main/screenshots/popular_musics.jpg" width="300" />
  <img src="https://github.com/VahanDag/song-app-flutter/blob/main/screenshots/song_record.jpg" width="300" />
</p>

This project is a simple music player app built with Flutter. Users can record and play their own music, view popular songs, and manage their profile with name and profile picture updates.

## Features

- Record and play your own music
- View and play popular songs
- Update profile name and picture
- Save data locally using shared_preferences

## Screenshots

Here are some screenshots of the app:

<p align="center">
  <img src="https://github.com/VahanDag/song-app-flutter/blob/main/screenshots/popular_musics.jpg" width="200" />
  <img src="https://github.com/VahanDag/song-app-flutter/blob/main/screenshots/song_record.jpg" width="200" />
</p>

## Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/music_player_app.git
   ```
2. Navigate to the project directory
   ```bash
   cd music_player_app
   ```
3. Install the dependencies
   ```bash
   flutter pub get
   ```

## Usage

1. Connect a device or start an emulator
2. Run the app
   ```bash
   flutter run
   ```

## Dependencies

- [audioplayers](https://pub.dev/packages/audioplayers)
- [flutter_sound](https://pub.dev/packages/flutter_sound)
- [lottie](https://pub.dev/packages/lottie)
- [path_provider](https://pub.dev/packages/path_provider)
- [permission_handler](https://pub.dev/packages/permission_handler)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [image_picker](https://pub.dev/packages/image_picker)

## Project Structure

```
lib
├── main.dart
├── views
│   ├── global_widgets.dart
│   ├── my_musics.dart
│   ├── popular_musics.dart
│   ├── profile_page.dart
└── service
    └── cache.dart
```

## Contributing

1. Fork the repository
2. Create a new branch
   ```bash
   git checkout -b feature/your-feature
   ```
3. Make your changes
4. Commit your changes
   ```bash
   git commit -m "Add your feature"
   ```
5. Push to the branch
   ```bash
   git push origin feature/your-feature
   ```
6. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
