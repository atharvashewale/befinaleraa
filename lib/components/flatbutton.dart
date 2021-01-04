import 'package:flutter/material.dart';

class MyFlatButton extends StatelessWidget {
  MyFlatButton({this.text, this.onPress, this.icon});

  final String text;
  final Function onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: Colors.white,
      splashColor: Colors.grey,
      textColor: Color(0xff1a1a2e),
      onPressed: () {
        onPress();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 35.0),
          ),
        ],
      ),
    );
  }
}
