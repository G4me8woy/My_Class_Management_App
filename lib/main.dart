import 'package:class_management_app/model/ListManager.dart';
import 'package:class_management_app/model/database.dart';
import 'package:class_management_app/widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/myAppBar.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/Handout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();
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

  final StudentDatabase db = StudentDatabase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(context: context, db: db),
        drawer: MyDrawer(),
        body: FutureBuilder<QuerySnapshot>(
            future: db.future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none)
                return Container(
                  child: Center(
                    child: Text("No connection"),
                  ),
                );

              if (snapshot.connectionState == ConnectionState.waiting)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              db.populateDataBase(snapshot);

              return ListManager(
                list: db.allStudents,
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
