import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:world_traveller/Components/bottom_navigation.dart';
import 'package:world_traveller/authentication/login_screen.dart';
import 'package:world_traveller/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToScreen();
  }

  // Function to navigate based on authentication status
  Future<void> _navigateToScreen() async {
    // Delay for 5 seconds
    await Future.delayed(const Duration(seconds: 5));

    // Check authentication status
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      // User is already logged in, navigate to home screen with bottom navigation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
      );
    } else {
      // User is not logged in, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(onLogout: () {
                  // Handle logout by navigating to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(onLogout: () {})),
                  );
                })),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColorSkyBlue, primaryColorOcenBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            Center(
              child: Image.asset(
                'assets/img/logo-main.png',
                width: size.width * 0.7,
                height: size.width * 0.7,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'World Traveller',
              style: TextStyle(
                fontSize: size.width * 0.08, // Adjust based on screen width
                fontWeight: FontWeight.bold,
                color: secondaryColorWhite,
                fontFamily: 'Poppins',
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(
              height: size.height * 0.4, // Adjust based on screen height
            ),
            Text(
              'Power By :-',
              style: TextStyle(
                color: secondaryColorWhite,
                fontSize: size.width * 0.045, // Adjust based on screen width
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: size.height * 0.005, // Adjust based on screen height
            ),
            Text(
              'Team Phoenix',
              style: TextStyle(
                color: secondaryColorWhite,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: size.width * 0.04, // Adjust based on screen width
              ),
            ),
          ],
        ),
      ),
    );
  }
}
