import 'package:demo/Screen/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase auth instance

  User? _user; // Firebase user object

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      _user = event;
      if (_user != null) {
        // Navigate to Home_Page if user is authenticated
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_Page()), // Replace with Home_Page widget
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _user != null ? _userInfo() : _loginPage(),
    );
  }

  Widget _loginPage() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'tag-1', // Provide a unique non-null tag
                  child: Lottie.asset(
                    'Assets/lotties/door.json',
                    repeat: true,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(
                      CupertinoIcons.person,
                      color: Colors.deepPurple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      CupertinoIcons.eye,
                      color: Colors.deepPurple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black12),
                ),
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: SignInButton(
                      Buttons.google,
                      text: "SignIn",
                      onPressed: _handleGoogleSignIn,
                    ),
                  ),
                  SizedBox(width: 5),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: SignInButton(
                      Buttons.apple,
                      text: "SignIn",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithProvider(_googleAuthProvider); // This needs credentials handling
    } catch (error) {
      print('Google Sign-In failed: $error');
    }
  }

  Widget _userInfo() {
    return Center(
      child: Text('Welcome, User!'), // You can modify this to show more user info
    );
  }
}
