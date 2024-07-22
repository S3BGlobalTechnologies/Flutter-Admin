// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart'; // Correct import

import 'screens/login.dart'; 

class MySplashScreen extends StatelessWidget { // No need for StatefulWidget here
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'S3B ADMIN',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          Lottie.asset(
            'assets/anim.json', 
            width: 200,
            height: 200,
          ),
        ],
      ),
      nextScreen: const LoginScreen(), 
      
      // splashBackgroundColor: Colors.white,
      duration: 3000, // Duration in milliseconds (3 seconds)
      splashTransition: SplashTransition.fadeTransition, // Optional transition
    );
  }
}