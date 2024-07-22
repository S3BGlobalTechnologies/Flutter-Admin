import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:employee/firebase_options.dart';
import 'package:employee/screens/theme.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_actions/quick_actions.dart';
import 'screens/DemoPage.dart';
import 'package:employee/screens/profile_screen.dart'; // Import ProfileScreen

import 'screens/login.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final QuickActions _quickActions = const QuickActions();

  @override
  void initState() {
    super.initState();
    _setupQuickActions();
  }

  void _setupQuickActions() {
    _quickActions.initialize((shortcutType) async {
      // Ensure the app has navigated to the first screen
      await WidgetsBinding.instance.endOfFrame;

      if (shortcutType != null) {
        switch (shortcutType) {
          case 'action_view_employee':
            await Future.delayed(Duration.zero);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DemoPage(employeeId: 'your employeeId')),
            );
            break;

          case 'action_view_profile':
            await Future.delayed(Duration.zero);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            break;
        }
      }
    });

    const ShortcutItem viewEmployee = ShortcutItem(
      type: 'action_view_employee',
      localizedTitle: 'View Employee',
      icon: 'ic_shortcut_view',
      
    );

    const ShortcutItem viewProfile = ShortcutItem(
      type: 'action_view_profile',
      localizedTitle: 'View Profile',
      icon: 'ic_shortcut_profile', // Make sure you have this icon
    );

    _quickActions.setShortcutItems([viewEmployee, viewProfile]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'S3B GLOBAL ADMIN',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            // const SizedBox(height: 10),
            Lottie.asset(
              'assets/anim.json',
              width: 400,
              height: 400,
            ),
          ],
        ),
        nextScreen: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return const Home();
              } else {
                return const LoginScreen();
              }
            }),
        //  splashBackgroundColor: Colors.white,
        duration: 3000,
        // Duration in milliseconds (3 seconds)
        splashTransition:
            SplashTransition.fadeTransition, // Optional transition
      ),
    );
  }
}
