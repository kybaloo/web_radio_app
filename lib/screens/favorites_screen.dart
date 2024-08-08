import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/stream_card.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(), // Initialize Firebase asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur d\'initialisation de Firebase: ${snapshot.error}'));
        }

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
            future: FirebaseFirestore.instance.collection('radios').get(), // Fetch the data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('Aucune radio favorite trouvée.'));
              }

              final favoriteRadios = snapshot.data!.docs.map((doc) {
                return doc.data() as Map<String, dynamic>; // Ensure type safety
              }).toList();

              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Vos Radio Favorites',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ...favoriteRadios.map((radio) {
                    return StreamCard(
                      color: Colors.purple, // Use a consistent color or generate colors dynamically
                      title: radio['name'] ?? 'Nom inconnu', // Provide a fallback for missing data
                      frequency: radio['frequency'] ?? 'Fréquence inconnue',
                      song: radio['song'] ?? 'Aucune chanson en cours',
                      isFavorite: radio['isFavorite'] ?? false,
                    );
                  }).toList(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
