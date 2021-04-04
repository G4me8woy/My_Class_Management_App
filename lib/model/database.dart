import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDatabase {
  Map<int, Map<String, dynamic>> allStudents = {};

  final Future<QuerySnapshot> futureSnapshot = FirebaseFirestore.instance
      .collection('students')
      .doc('CPS')
      .collection('100')
      .doc('1A')
      .collection('members')
      .get();

  Future<QuerySnapshot> get future async {
    return await futureSnapshot;
  }
}
