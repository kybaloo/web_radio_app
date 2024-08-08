import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:web_radio_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var audioProvider = Provider.of<AudioProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                  'assets/radio_image.jpg'), // replace with your image asset
            ),
            SizedBox(height: 16),
            Text(
              'Elite Street FM',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '80.4 HZ',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Weird Genius - LATHI (ft. Sara Fajira)',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 36),
                  onPressed: () {},
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(
                    audioProvider.isPlaying
                      ? FontAwesomeIcons.pause
                      : FontAwesomeIcons.play,
                    size: 64.0,
                  ),
                  onPressed: audioProvider.togglePlayPause,
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 36),
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.download, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'TRACK DAY LIST',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
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

/* 
class RadioPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/radio_image.jpg'), // replace with your image asset
            ),
            SizedBox(height: 16),
            Text(
              'Elite Street FM',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '80.4 HZ',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Weird Genius - LATHI (ft. Sara Fajira)',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, size: 36),
                  onPressed: () {},
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.play_circle_fill, size: 64, color: Colors.blue),
                  onPressed: () {},
                ),
                SizedBox(width: 24),
                IconButton(
                  icon: Icon(Icons.skip_next, size: 36),
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.download, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'TRACK DAY LIST',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
*/
