// @dart=2.9

import 'package:class_management_app/model/ListManager.dart';
import 'package:class_management_app/model/database.dart';
import 'package:class_management_app/screens/AuthScreen.dart';
import 'package:class_management_app/test/AuthScreenTest.dart';
import 'package:class_management_app/widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'screens/Home.dart';
import 'widgets/myAppBar.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/Handout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  // await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(accentColor: Colors.blue, highlightColor: Colors.blue),
    title: "Class Management App",
    routes: {"/handout": (context) => HandOutScreen()},
    home: FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Some Error Occured Linking Firebase"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print("firebase_core initialized");
          return AuthScreenTest();
        }
        print("searching");
        return Center(child: CircularProgressIndicator());
      },
    ),
  ));
}
