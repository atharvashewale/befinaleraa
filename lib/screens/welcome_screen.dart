import 'package:befinaleraa/components/filledButton.dart';
import 'package:befinaleraa/screens/login_screen.dart';
import 'package:befinaleraa/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/ic_launcher-playstore.png'),
                    height: 200.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            FilledButton("Log In", Colors.grey, Colors.grey, Colors.white,
                Color(0xff444f5a), () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            SizedBox(
              height: 10.0,
            ),
            FilledButton("Sign Up", Colors.grey, Colors.grey, Colors.white,
                Color(0xff444f5a), () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
          ],
        ),
      ),
    );
  }
}
