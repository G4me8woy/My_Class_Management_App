import 'package:class_management_app/widgets/Members.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Members.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final textController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 50,
      margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              onChanged: (value) {
                print(value);
              },
              decoration: InputDecoration(fillColor: Colors.black),
            ),
          ),
          SvgPicture.asset(
            "assets/images/loupe.svg",
            height: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
