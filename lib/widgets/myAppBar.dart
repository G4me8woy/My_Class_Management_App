import 'package:class_management_app/model/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final StudentDatabase db;

  const MyAppBar({this.context, this.db});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
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
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class SearchFunction extends SearchDelegate {
  // StudentDatabase database;
  // Map<int, Map<String, dynamic>> studentQueryList;

  List<Map<String, dynamic>> studentsList = [];

  SearchFunction(StudentDatabase data) {
    studentsList = data.allStudents;
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
