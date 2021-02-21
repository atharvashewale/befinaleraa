import 'dart:io';

import 'package:befinaleraa/components/flatbutton.dart';
import 'package:befinaleraa/constants.dart';
import 'package:befinaleraa/screens/od_results.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

List<String> results = List<String>();

class ObjectDetection extends StatefulWidget {
  static const String id = 'object_detection';

  @override
  _ObjectDetectionState createState() => _ObjectDetectionState();
}

class _ObjectDetectionState extends State<ObjectDetection> {
  static File pickedImage;
  var text = '';
  bool imageLoaded = false;

  Future pickImageGallery() async {
    var awaitImage = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (awaitImage != null) {
        pickedImage = File(awaitImage.path);
        imageLoaded = true;
      } else {
        print('No image selected');
      }
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    for (ImageLabel label in labels) {
      final double confidence = label.confidence;
      setState(() {
        text =
            "Label: ${label.text}   Confidence: ${(confidence * 100).toStringAsFixed(2)} %";
      });
      results.add(text);
    }
    labeler.close();
  }

  Future pickImageCamera() async {
    var awaitImage = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (awaitImage != null) {
        pickedImage = File(awaitImage.path);
        imageLoaded = true;
      } else {
        print('No image selected');
      }
    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    final List<ImageLabel> labels = await labeler.processImage(visionImage);
    for (ImageLabel label in labels) {
      final double confidence = label.confidence;
      setState(() {
        text =
            "Label: ${label.text}   Confidence: ${(confidence * 100).toStringAsFixed(2)} %";
      });
      results.add(text);
    }
    labeler.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Object Detection',
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
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Select an image from Gallery or Click from Camera.',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyFlatButton(
                        text: 'Camera',
                        icon: Icons.camera,
                        onPress: pickImageCamera,
                      ),
                      MyFlatButton(
                        text: 'Gallery',
                        icon: Icons.collections,
                        onPress: pickImageGallery,
                      ),
                    ],
                  ),
                ),
                SnackBarPage(
                  result: results,
                  selectedImage: pickedImage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  SnackBarPage({this.result, this.selectedImage});
  List<String> result = List<String>();
  File selectedImage;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      color: Colors.white,
      textColor: kbackgroundScreenColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: () async {
        if (selectedImage == null && results.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please Select an Image First'),
            action: SnackBarAction(
              label: 'Error',
              onPressed: () {},
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ODResults(
                  result: Padding(
                padding: EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    for (int i = 0; i < result.length; i++)
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          result[i],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      )
                  ],
                ),
              ));
            }),
          );
          results.clear();
        }
      },
      child: Text(
        'Show Results',
        style: TextStyle(
          color: Color(0xff133b5c),
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
