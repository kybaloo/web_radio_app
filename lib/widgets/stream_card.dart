import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StreamCard extends StatelessWidget {
  final Color color;
  final String title;
  final String frequency;
  final String song;
  final bool isFavorite;

  StreamCard({
    required this.color,
    required this.title,
    required this.frequency,
    required this.song,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.radio, color: Colors.white),
              if (isFavorite)
                Icon(Icons.favorite, color: Colors.white),
            ],
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            frequency,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          if (song.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                song,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ),
        ],
      ),
    );
  }
}