import 'package:android_intent/android_intent.dart';
import 'package:befinaleraa/screens/object_detection.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow_v2.dart' as df;
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:intent/action.dart' as android_action;
import 'package:intent/extra.dart' as android_extra;
import 'package:intent/intent.dart' as android_intent;
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing_screen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void response(query) async {
    _textController.clear();
    df.AuthGoogle authGoogle = await df.AuthGoogle(
            fileJson: "assets/eraa-an-artificial-companion-0eaf43631197.json")
        .build();
    df.Dialogflow dialogflow = df.Dialogflow(authGoogle: authGoogle);
    df.DetectIntentResponse response =
        await dialogflow.detectIntentFromText(query, df.Language.english);
    ChatMessage message = new ChatMessage(
      text: response.queryResult.fulfillmentText,
      name: 'ERAA',
      type: false,
    );

    setState(() {
      _messages.insert(0, message);
    });

    if (response.queryResult.action.contains("whatsapp_launch")) {
      await LaunchApp.openApp(
        androidPackageName: 'com.whatsapp',
      );
    }

    if (response.queryResult.action.contains("instagram_launch")) {
      await LaunchApp.openApp(
        androidPackageName: 'com.instagram.android',
      );
    }

    if (response.queryResult.action.contains("gmail_launch")) {
      await LaunchApp.openApp(
        androidPackageName: 'com.google.android.gm',
      );
    }

    if (response.queryResult.action.contains("sendEmail_launch")) {
      final Email email = Email(
        body: 'I sent this mail from my flutter app',
        subject: 'Email from flutter app',
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    }

    if (response.queryResult.action.contains("camera_launch")) {
      android_intent.Intent()
        ..setAction(android_action.Action.ACTION_IMAGE_CAPTURE)
        ..startActivityForResult().then((data) => print(data[0]));
    }

    if (response.queryResult.action.contains("callDialer_launch")) {
      android_intent.Intent()
        ..setAction(android_action.Action.ACTION_DIAL)
        ..setData(Uri(scheme: 'tel', path: ''))
        ..startActivity().catchError((e) => print(e));
    }

    if (response.queryResult.action.contains("objectDetection_launch")) {
      Navigator.pushNamed(context, ObjectDetection.id);
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: 'User',
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ERAA'),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child:
            new CircleAvatar(child: new Image.asset('assets/placeholder.jpg')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.bodyText1),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(child: new Text(this.name[0])),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
