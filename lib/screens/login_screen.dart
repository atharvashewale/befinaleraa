import 'package:befinaleraa/components/customTextField.dart';
import 'package:befinaleraa/components/filledButton.dart';
import 'package:befinaleraa/screens/features_screen.dart';
import 'package:befinaleraa/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _autoValidate = false;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  bool showspinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 125.0,
                    child: Image.asset('images/ic_launcher-playstore.png'),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    CustomTextField(
                      icon: Icon(Icons.mail),
                      hint: "Enter Email",
                      obscure: false,
                      onSaved: (value) {
                        email = value;
                      },
                      keyboard: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    CustomTextField(
                      icon: Icon(Icons.lock),
                      hint: "Enter Password",
                      obscure: true,
                      onSaved: (value) {
                        password = value;
                      },
                      keyboard: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a valid password!';
                        }
                        if (value.length < 6) {
                          return "Minimum length should be 6";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              FilledButton("Log In", Colors.grey, Colors.blueAccent,
                  Colors.white, Color(0xff444f5a), () async {
                final FormState form = _formKey.currentState;
                if (_formKey.currentState.validate()) {
                  form.save();
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, LandingScreen.id);
                    }
                    setState(() {
                      showspinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      showspinner = false;
                    });
                    print('Failed with error code: ${e.code}\n');
                    print(e.message);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              child: Text(
                                  "Failed with error code: ${e.code}\n${e.message}"),
                            ),
                          );
                        });
                  }
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
