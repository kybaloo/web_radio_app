import 'package:flutter/material.dart';
import 'package:web_radio_app/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'register_screen.dart';

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
                child: Image.asset(
                  'assets/images/undraw_recording_re_5xyq.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                'Vos radios favorites au plus prêt',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Description
              Text(
                'Trouvez toutes vos chaînes radios et vos chaînes de Podcasts favorites à portée dans notre application Web Radio.',
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
                      color: index == 0 ? Colors.purple : Colors.grey,
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
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text('S\'inscrire'),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Handle sign in button press
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      side: BorderSide(color: Colors.purple),
                    ),
                    child: Text('Se Connecter', style: TextStyle(color: Colors.purple),),
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
