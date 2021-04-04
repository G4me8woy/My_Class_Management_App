import 'package:class_management_app/model/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StudentDatabase db = StudentDatabase();

    return FutureBuilder<QuerySnapshot>(
        future: db.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none)
            //TODO: build no connection screen
            return Center(
              child: Text("No connection"),
            );
          if (snapshot.connectionState == ConnectionState.waiting)
            //TODO: build waiting screen
            return Center(
              child: CircularProgressIndicator(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        });
  }
}
