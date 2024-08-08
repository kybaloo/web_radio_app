import 'package:flutter/material.dart';

class NowPlayingCard extends StatelessWidget {
  final String title;
  final String frequency;
  final String song;

  NowPlayingCard({
    required this.title,
    required this.frequency,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.play_circle_fill, color: Colors.deepPurple, size: 40),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    frequency,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            song,
            style: TextStyle(fontSize: 16, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}