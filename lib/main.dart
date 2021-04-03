import 'package:class_management_app/model/ListManager.dart';
import 'package:class_management_app/widgets/Description.dart';
import 'package:class_management_app/widgets/Members.dart';
import 'package:class_management_app/widgets/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(accentColor: Colors.blue, highlightColor: Colors.blue),
    title: "Class Management App",
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
          return Home();
        }
        print("searching");
        return Center(child: CircularProgressIndicator());
      },
    ),
  ));
}

class Home extends StatelessWidget {
  final Future<DocumentSnapshot> x =
      FirebaseFirestore.instance.collection('students').doc().get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: x,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("loading firebase");
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              print("couldn't connect to firebase");
              return Scaffold(
                body: Center(
                  child: Text("No Connection"),
                ),
              );
            }

            print("connected to firebase");
            return Scaffold(
              drawer: Drawer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {}, child: Text("African Studies")),
                    TextButton(
                        onPressed: () {}, child: Text("Communication Skills")),
                    TextButton(onPressed: () {}, child: Text("Circuit Theory")),
                    TextButton(onPressed: () {}, child: Text("Computing")),
                    TextButton(onPressed: () {}, child: Text("Programming")),
                    TextButton(onPressed: () {}, child: Text("Statistics")),
                    TextButton(onPressed: () {}, child: Text("Mathematics")),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Search(),
                  Description(),
                  Expanded(
                      child: Container(
                    child: Members(),
                  ))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: Text("Press"),
                onPressed: () async {
                  ListManager listObj = new ListManager();
                  await listObj.setallStudentList;
                  // print(listObj.getsearchResults("Linda"));
                  print("test run");
                },
              ),
            );
          }),
    );
  }
}
