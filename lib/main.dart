import 'package:befinaleraa/screens/interconnected_apps.dart';
import 'package:befinaleraa/screens/login_screen.dart';
import 'package:befinaleraa/screens/od_results.dart';
import 'package:befinaleraa/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/features_screen.dart';
import 'screens/interconnected_apps.dart';
import 'screens/object_detection.dart';
import 'screens/speech_to_text.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(ERAA());
}

class ERAA extends StatefulWidget {
  @override
  _ERAAState createState() => _ERAAState();
}

class _ERAAState extends State<ERAA> {
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ERAA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        FeaturesScreen.id: (context) => FeaturesScreen(),
        SpeechToText.id: (context) => SpeechToText(),
        ObjectDetection.id: (context) => ObjectDetection(),
        ODResults.id: (context) => ODResults(),
        InterconnectedApps.id: (context) => InterconnectedApps(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen()
      },
    );
  }
}
