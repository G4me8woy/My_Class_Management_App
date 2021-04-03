import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ListManager {
  ListManager();

  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('students')
      .doc('CPS')
      .collection('100')
      .doc('1A')
      .collection('members');

  QuerySnapshot querySnapshot;
  // List<QueryDocumentSnapshot> allStudents;
  List<Map<String, dynamic>> allStudents = [];
  List<QueryDocumentSnapshot> searchResult;

  Future<void> get setallStudentList async {
    await collectionReference.get().then((value) => value.docs.map((doc) {
          return doc.data();
        }).forEach((data) {
          print(data);
          allStudents.add(data);
        }));
    print(allStudents);
  }

  List<Map<String, dynamic>> getallStudents() {
    return allStudents;
  }
}
