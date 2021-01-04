import 'package:befinaleraa/screens/interconnected_apps.dart';
import 'package:befinaleraa/screens/od_results.dart';

import 'screens/features_screen.dart';
import 'screens/speech_to_text.dart';
import 'screens/object_detection.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/interconnected_apps.dart';

void main() {
  runApp(ERAA());
}

class ERAA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      },
    );
  }
}
