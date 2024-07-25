import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AudioProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Radio App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Radio App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioInfo(),
            PlayerControls(),
          ],
        ),
      ),
    );
  }
}

class RadioInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          FontAwesomeIcons.radio,
          size: 100,
          color: Colors.blue,
        ),
        SizedBox(height: 20),
        Text(
          'Your Radio Station',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Streaming live music 24/7',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var audioProvider = Provider.of<AudioProvider>(context);

    return Column(
      children: [
        IconButton(
          icon: Icon(
            audioProvider.isPlaying
                ? FontAwesomeIcons.pause
                : FontAwesomeIcons.play,
            size: 64.0,
          ),
          onPressed: audioProvider.togglePlayPause,
        ),
        SizedBox(height: 20),
        Text(
          audioProvider.isPlaying ? 'Playing' : 'Paused',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class AudioProvider with ChangeNotifier {
  final _player = AudioPlayer();
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  AudioProvider() {
    _init();
  }

  Future<void> _init() async {
    await _player.setUrl('http://cdn.nrjaudio.fm/audio1/fr/30001/mp3_128.mp3');
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _player.pause();
    } else {
      _player.play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
