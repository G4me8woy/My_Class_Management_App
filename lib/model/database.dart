import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDatabase {
  List<Map<String, dynamic>> allStudents = [];

  QuerySnapshot futureSnapshot;

  void getMembers() async {
    futureSnapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc('CPS')
        .collection('100')
        .doc('1A')
        .collection('members')
        .get();
  }

  void populateDataBase(AsyncSnapshot<QuerySnapshot> snapshot) {
    int index = 0;
    snapshot.data.docs.forEach((element) {
      Map<String, dynamic> studentDetails = element.data();
      allStudents.add(studentDetails);
      index++;
    });
  }
}
