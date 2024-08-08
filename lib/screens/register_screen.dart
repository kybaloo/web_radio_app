import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:web_radio_app/screens/home_screen.dart';
import 'package:web_radio_app/screens/login_screen.dart';
import 'package:web_radio_app/screens/radio_stream_screen.dart'; // Import HomeScreen

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController(); // Added for full name
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose(); // Dispose of full name controller
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ).then((user) {
          // Store full name in Firebase Realtime Database or Firestore
          // Assuming the use of Firebase Realtime Database for simplicity
          user.user?.updateProfile(displayName: _fullNameController.text);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Compte créé avec succès.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RadioStreamScreen()), // Redirect to HomeScreen
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentification non réussie: ${e.message}')),
        );
      }
    }
  }

  Future<void> _registerWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription avec Google réussie.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RadioStreamScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription échouée : ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Créez un compte',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Navigate to login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Vous avez déjà un compte ? Connexion",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _fullNameController, // Full name text field
                decoration: InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Renseignez votre nom complet';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Renseignez votre adresse mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de Passe',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Entrez un mot de passe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: Text('Inscrition'),
              ),
              SizedBox(height: 16),
              Text('ou s\'inscrire avec'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.network('https://img.icons8.com/color/48/000000/google-logo.png'),
                    onPressed: _registerWithGoogle,
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
            ],
          ),
        ),
      ),
    
      )
    );
  }
}
