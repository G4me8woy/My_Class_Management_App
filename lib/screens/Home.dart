import 'package:class_management_app/model/ListManager.dart';
import 'package:class_management_app/widgets/myDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // final StudentDatabase db = StudentDatabase();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          // appBar: MyAppBar(context: context, db: db),
          drawer: MyDrawer(),
          body: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('students')
                  .doc('CPS')
                  .collection('100')
                  .doc('1A')
                  .collection('members')
                  .get(),

              // /students/CPS/100/1A/members/01200404D
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none)
                  return Container(
                    child: Center(
                      child: Text("No connection"),
                    ),
                  );

                if (snapshot.hasError)
                  return Container(
                    child: Center(
                      child: Text("Errors"),
                    ),
                  );

                if (snapshot.connectionState == ConnectionState.waiting)
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                // db.populateDataBase(snapshot);

                // return Container(
                //   child: Center(
                //     child: FlutterLogo(),
                //   ),
                // );

                List<Map<String, dynamic>> _list =
                    new List.generate(0, (index) => null, growable: true);

                // int index = 0;
                snapshot.data.docs.forEach((DocumentSnapshot doc) {
                  _list.add(doc.data());
                });

                return ListManager(
                  list: _list,
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
