import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/stream_card.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assuming there's a list of favorite radios stored in a variable 'favoriteRadios'
    // This list should be fetched from a database or a storage service
    // For demonstration, we'll use a static list
    Firebase.initializeApp();
    // final List<Map<String, dynamic>> favoriteRadios = [
    //   {'name': 'NRJ Radio', 'frequency': '100.0 MHz', 'song': 'Julian Jordan - Oldskool', 'isFavorite': true},
    //   {'name': 'BBC Radio 1', 'frequency': '88.0 MHz', 'song': '', 'isFavorite': true},
    //   {'name': 'Classic Rock', 'frequency': '95.5 MHz', 'song': 'Led Zeppelin - Stairway to Heaven', 'isFavorite': true},
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('radios').get(), // Récupération des données
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final favoriteRadios = snapshot.data!.docs.map((doc) => doc.data()).toList(); // Transformation des données

          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Text(
                'Vos Radio Favorites',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...favoriteRadios.map((radio, index) => StreamCard(
                color: Colors.purple[index % Colors.purple.length],
                title: radio?['name'],
                frequency: radio['frequency'],
                song: radio['song'],
                isFavorite: radio['isFavorite'],
              )).toList(),
            ],
          );
        },
      ),
    );
  }
}
