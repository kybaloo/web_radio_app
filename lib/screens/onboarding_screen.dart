import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PresentationPage(),
    );
  }
}

class PresentationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image
              Container(
                width: 200,
                height: 200,
                child: Image.network(
                  'https://path-to-your-image.com/your-image.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                'Transform Speech into Text Effortlessly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Description
              Text(
                'Capture every detail with RecogNotes. Record conversations, lectures, meetings, and more, and watch as they are transcribed into accurate text instantly.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              // Dots indicator (you can customize this if needed)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0 ? Colors.blue : Colors.grey,
                    ),
                  );
                }),
              ),
              SizedBox(height: 24),
              // Register and Sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle register button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text('Register'),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Handle sign in button press
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text('Sign in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
