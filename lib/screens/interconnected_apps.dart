import 'package:befinaleraa/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:intent/action.dart' as android_action;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/intent.dart' as android_intent;

class InterconnectedApps extends StatefulWidget {
  static const String id = 'interconnected_apps';
  @override
  _InterconnectedAppsState createState() => _InterconnectedAppsState();
}

class _InterconnectedAppsState extends State<InterconnectedApps> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Interconnected Apps',
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
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              BuildFlatButton(
                text: 'Call',
                icon: Icons.phone,
                onpress: () {
                  android_intent.Intent()
                    ..setAction(android_action.Action.ACTION_DIAL)
                    ..setData(Uri(scheme: 'tel', path: ''))
                    ..startActivity().catchError((e) => print(e));
                },
              ),
              BuildFlatButton(
                text: 'Mail',
                icon: Icons.mail,
                onpress: () {
                  android_intent.Intent()
                    ..setAction(android_action.Action.ACTION_VIEW)
                    ..setData(Uri(scheme: "mailto", path: ""))
                    ..startActivity().catchError((e) => print(e));
                },
              ),
              BuildFlatButton(
                text: 'Google Search',
                icon: Icons.search,
                onpress: () {
                  android_intent.Intent()
                    ..setAction(android_action.Action.ACTION_VIEW)
                    ..setData(Uri(scheme: "https", host: "google.com"))
                    ..startActivity().catchError((e) => print(e));
                },
              ),
              BuildFlatButton(
                text: 'Translate Text',
                icon: Icons.translate,
                onpress: () {
                  android_intent.Intent()
                    ..setAction(android_action.Action.ACTION_TRANSLATE)
                    ..putExtra(
                        android_extra.Extra.EXTRA_TEXT, "I Love Computers")
                    ..startActivity().catchError((e) => print(e));
                },
              ),
              BuildFlatButton(
                text: 'Show WhatsApp',
                icon: Icons.chat,
                onpress: () {
                  FlutterOpenWhatsapp.sendSingleMessage("8459216871", "Hello");
                },
              ),
              BuildFlatButton(
                text: 'Take Picture',
                icon: Icons.camera_alt,
                onpress: () {
                  android_intent.Intent()
                    ..setAction(android_action.Action.ACTION_IMAGE_CAPTURE)
                    ..startActivityForResult().then((data) => print(data[0]));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildFlatButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onpress;

  BuildFlatButton({this.text, this.icon, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: FlatButton(
        color: Colors.white,
        splashColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 35.0,
            ),
            Icon(
              icon,
              size: 30.0,
              color: kbackgroundScreenColor,
            ),
            SizedBox(
              width: 35.0,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(0xff133b5c),
                fontSize: 25.0,
              ),
            ),
          ],
        ),
        onPressed: onpress,
      ),
    );
  }
}
