import 'package:befinaleraa/screens/features_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:befinaleraa/constants.dart';
import 'package:befinaleraa/components/flatbutton.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.black, end: kbackgroundScreenColor)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alpha Version 1.0'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ERAA is in initial development stage.'),
                Text('More functionality will be added in later updates.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kbackgroundScreenColor,
        appBar: AppBar(
          title: Text(
            'ERAA',
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
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyFlatButton(
                        icon: Icons.playlist_add_check,
                        text: 'Test Features',
                        onPress: () async {
                          await _showMyDialog();
                          Navigator.pushNamed(context, FeaturesScreen.id);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
