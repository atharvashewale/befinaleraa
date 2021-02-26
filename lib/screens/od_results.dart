import 'package:flutter/material.dart';
import 'package:befinaleraa/constants.dart';

class ODResults extends StatelessWidget {
  static const String id = 'od_results';
  ODResults({this.result});
  final Widget result;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Results',
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
          body: result),
    );
  }
}
