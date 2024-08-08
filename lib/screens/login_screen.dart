import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:web_radio_app/screens/home_screen.dart';
import 'package:web_radio_app/screens/radio_stream_screen.dart';

import 'register_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithEmail() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RadioStreamScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion échouée : ${e.message}')),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RadioStreamScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion échouée: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Connectez-vous',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Entrez vos informations de connexion',
                style: TextStyle(fontSize: 14,),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Navigate to recovery password page
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Mot de Passe oublié ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loginWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: Text('Continuer'),
              ),
              SizedBox(height: 16),
              Text('ou se connecter avec'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.network('https://img.icons8.com/color/48/000000/google-logo.png'),
                    onPressed: _loginWithGoogle,
                  ),
                  IconButton(
                    icon: Image.network('https://img.icons8.com/ios-filled/50/000000/mac-os.png'),
                    onPressed: () {
                      // Handle Apple sign up
                    },
                  ),
                  IconButton(
                    icon: Image.network('https://img.icons8.com/fluency/48/000000/facebook-new.png'),
                    onPressed: () {
                      // Handle Facebook sign up
                    },
                  ),
                ],
              ),
              
              SizedBox(height: 24),
               
              Text(
                "Vous n'avez pas de compte ?",
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  " S'inscrire",
                  style: TextStyle(color: Colors.blue),
                ),
              ), 
              
              SizedBox(height: 24),
              Text(
                'By clicking Create account you agree to Recognotes',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to terms of use
                },
                child: Text(
                  'Terms of use and Privacy policy',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}