import 'package:class_management_app/widgets/search.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 60,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "all (1C)",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class seachfunctions extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
