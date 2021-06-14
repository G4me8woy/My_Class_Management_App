import 'package:class_management_app/model/database.dart';
import 'package:flutter/material.dart';

class ListManager extends StatelessWidget {
  final List<Map<String, dynamic>> list;

  const ListManager({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawScrollbar(
      thumbColor: Colors.blue,
      isAlwaysShown: true,
      child: ListView.builder(
          itemCount: list.length,
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
                          "${list[index]['name']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${list[index]['id']}",
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
