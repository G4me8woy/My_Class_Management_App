import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  Map data = {};

  Future<void> getFirebaseData() async {
    try {
      print("getting data from fire store");

      await FirebaseFirestore.instance
          .collection('students')
          .get()
          .then((value) => value.docs.asMap().forEach((key, value) {
                data[key] = value[100];
              }));
      print("done getting data");
    } catch (e) {
      print("Error occured getting data from firebase");
    }
  }

  Map getLocalDatabase() {
    return data;
  }
}
