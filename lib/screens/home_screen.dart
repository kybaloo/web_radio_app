import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> webRadios = [
    {'name': 'Radio One', 'url': 'https://radioone.com/stream'},
    {'name': 'Jazz FM', 'url': 'https://jazzfm.com/stream'},
    {'name': 'Classic Rock', 'url': 'https://classicrock.com/stream'},
    {'name': 'Pop Hits', 'url': 'https://pophits.com/stream'},
    {'name': 'Hip Hop Beats', 'url': 'https://hiphopbeats.com/stream'},
    {
      'name': 'NRJ',
      'url': 'http://cdn.nrjaudio.fm/audio1/fr/30001/mp3_128.mp3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Radio App'),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            onPressed: () {
              // Implement search functionality
              showSearch(
                context: context,
                delegate: RadioSearchDelegate(webRadios),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: webRadios.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(FontAwesomeIcons.radio),
                title: Text(webRadios[index]['name']!),
                subtitle: Text(webRadios[index]['url']!),
                onTap: () {
                  // Implement radio stream functionality
                },
              ),
            );
          },
        ),
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
        },
      ),
    );
  }
}

class RadioSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> webRadios;

  RadioSearchDelegate(this.webRadios);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = webRadios
        .where((radio) =>
            radio['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.radio),
          title: Text(results[index]['name']!),
          subtitle: Text(results[index]['url']!),
          onTap: () {
            // Implement radio stream functionality
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = webRadios
        .where((radio) =>
            radio['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.radio),
          title: Text(suggestions[index]['name']!),
          subtitle: Text(suggestions[index]['url']!),
          onTap: () {
            query = suggestions[index]['name']!;
            showResults(context);
          },
        );
      },
    );
  }
}
