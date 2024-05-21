import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_rent/presentation/pages/home/view/home.dart';
import 'package:home_rent/presentation/pages/details_page/view/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  void checkAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ScreenHome()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),  // Optional: display a loading indicator
        ),
      ),
    );
  }
}
