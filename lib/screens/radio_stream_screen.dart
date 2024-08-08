import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gesture_detector/gesture_detector.dart'; // Import GestureDetector

import '../widgets/now_playing_card.dart';
import '../widgets/stream_card.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'player_screen.dart'; // Import player screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RadioStreamScreen(),
    );
  }
}

class RadioStreamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'All streams',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          GestureDetector( // Wrap StreamCard with GestureDetector
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayerScreen()),
              );
            },
            child: StreamCard(
              color: Colors.deepPurple,
              title: 'NRJ Radio',
              frequency: '100.0 MHz',
              song: 'Julian Jordan - Oldskool',
              isFavorite: true,
            ),
          ),
          SizedBox(height: 16),
          GestureDetector( // Wrap StreamCard with GestureDetector
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayerScreen()),
              );
            },
            child: StreamCard(
              color: Colors.lightBlueAccent,
              title: 'BBC Radio 1',
              frequency: '88.0 MHz',
              song: '',
              isFavorite: false,
            ),
          ),
          SizedBox(height: 16),
          NowPlayingCard(
            title: 'NRJ Radio',
            frequency: '100.0MHz',
            song: 'Joyryde - Hot Drum',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Implement navigation functionality
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FavoritesScreen()),
            );
            break;
          case 2:
            // Assuming there's a profile screen to navigate to
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileScreen()),
            // );
            break;
        }
        },
      ),
    );
  }
}