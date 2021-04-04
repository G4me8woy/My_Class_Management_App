import 'package:class_management_app/model/ListManager.dart';
import 'package:class_management_app/model/database.dart';
import 'package:class_management_app/widgets/Description.dart';
import 'package:class_management_app/widgets/Members.dart';
import 'package:class_management_app/widgets/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';

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

  final StudentDatabase db = StudentDatabase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: FutureBuilder(
      //     future: x,
      //     builder: (context, snapshot) {
      // if (snapshot.connectionState == ConnectionState.waiting) {
      //   print("loading firebase");
      //   return Scaffold(
      //     body: Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   );
      // }
      // if (snapshot.connectionState == ConnectionState.none) {
      //   print("couldn't connect to firebase");
      //   return Scaffold(
      //     body: Center(
      //       child: Text("No Connection"),
      //     ),
      //   );
      // }

      // print("connected to firebase");

      //////////////////////////////////////////////////////
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "all (1C)",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/images/loupe.svg",
                height: 30,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchFunction(db));
              },
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: Text("African Studies")),
              TextButton(onPressed: () {}, child: Text("Communication Skills")),
              TextButton(onPressed: () {}, child: Text("Circuit Theory")),
              TextButton(onPressed: () {}, child: Text("Computing")),
              TextButton(onPressed: () {}, child: Text("Programming")),
              TextButton(onPressed: () {}, child: Text("Statistics")),
              TextButton(onPressed: () {}, child: Text("Mathematics")),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: db.future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none)
                //TODO: build no connection screen
                return Container(
                  child: Center(
                    child: Text("No connection"),
                  ),
                );
              if (snapshot.connectionState == ConnectionState.waiting)
                //TODO: build waiting screen
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              int index = 0;
              snapshot.data.docs.forEach((element) {
                Map<String, dynamic> studentDetails = element.data();
                db.allStudents[index] = studentDetails;
                index++;
              });

              return RawScrollbar(
                thumbColor: Colors.black,
                child: ListView.builder(
                    itemCount: db.allStudents.length,
                    itemBuilder: (buildContext, index) {
                      return Container(
                        height: 100,
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: FlutterLogo(),
                              radius: 40,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${db.allStudents[index]['name']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    "${db.allStudents[index]['id']}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}

class SearchFunction extends SearchDelegate {
  // StudentDatabase database;
  // Map<int, Map<String, dynamic>> studentQueryList;

  List<Map<String, dynamic>> studentsList = [];

  SearchFunction(StudentDatabase data) {
    data.allStudents.forEach((key, value) {
      studentsList.add(value);
    });
    print(studentsList);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(child: Text("Results"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    List<Map<String, dynamic>> queryList = query.length == 0
        ? []
        : studentsList
            .where((element) => (element['name'] +
                    element[
                        'id']) //TODO: learn and implement RegEx for better search algorithm
                .toString()
                .contains(query.toUpperCase()))
            .toList();

    return Container(
      child: ListView.builder(
          itemCount: queryList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  CircleAvatar(
                    child: FlutterLogo(),
                    radius: 40,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${queryList[index]['name']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${queryList[index]['id']}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
