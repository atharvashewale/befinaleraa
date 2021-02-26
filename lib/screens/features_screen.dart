import 'package:befinaleraa/components/flatbutton.dart';
import 'package:befinaleraa/screens/interconnected_apps.dart';
import 'package:befinaleraa/screens/object_detection.dart';
import 'package:befinaleraa/screens/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:befinaleraa/constants.dart';
import 'package:flutter/widgets.dart';

class FeaturesScreen extends StatefulWidget {
  static const String id = 'features_screen';
  @override
  _FeaturesScreenState createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Features',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 25.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: kbackgroundScreenColor,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: MyFlatButton(
                  text: 'Speech-To-Text',
                  onPress: () {
                    Navigator.pushNamed(context, SpeechToText.id);
                  },
                  icon: Icons.mic,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: MyFlatButton(
                  text: 'Object Recognition',
                  icon: Icons.scanner,
                  onPress: () {
                    Navigator.pushNamed(context, ObjectDetection.id);
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: MyFlatButton(
                  text: 'Interconnected Apps',
                  icon: Icons.apps,
                  onPress: () {
                    Navigator.pushNamed(context, InterconnectedApps.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
