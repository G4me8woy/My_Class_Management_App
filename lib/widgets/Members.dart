import 'package:class_management_app/model/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  final Future futureSnapshot = FirebaseFirestore.instance
      .collection('students')
      .doc('CPS')
      .collection('100')
      .doc('1A')
      .collection('members')
      .get();

  List<DocumentSnapshot> stuList;
  List stuSearchList;

  void updateList(String input) {
    if (input.length > 0) {
      stuSearchList.clear();
      stuList.map((stu) {
        if (stu['name'].contains(input))
          stuSearchList.add(stu);
        else if (stu['id'].contains(input)) stuSearchList.add(stu);
      });
    }
    if (input.length == 0) stuSearchList = stuList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: futureSnapshot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none)
            return Center(
              child: Text("No connection"),
            );
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );

          //getting document list
          stuList = snapshot.data.docs;
          stuSearchList = stuList;

          return RawScrollbar(
            thumbColor: Colors.black,
            child: ListView.builder(
                itemCount: stuList.length,
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
                                "${stuSearchList[index]['name']}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                "${stuSearchList[index]['id']}",
                                style: TextStyle(color: Colors.white),
                              ),
                              // Row(
                              //   children: [
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //     CircleAvatar(
                              //         child: FlutterLogo(), radius: 10),
                              //     SizedBox(width: 5),
                              //   ],
                              // )
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
