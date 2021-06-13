// @dart=2.9

import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int switchControl = 0;
  bool _keyboardState;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  KeyboardVisibilityNotification _keyboardVisibilityObj =
      new KeyboardVisibilityNotification();

  @override
  void initState() {
    super.initState();

    _keyboardState = _keyboardVisibilityObj.isKeyboardVisible;

    _keyboardVisibilityObj.addNewListener(
      onChange: (stateChange) {
        setState(() {
          _keyboardState = stateChange;
          // FocusScope.of(context).unfocus();

          if (!_keyboardState) {
            focusNode1.unfocus();
            focusNode2.unfocus();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // if (!_keyboardState) FocusScope.of(context).unfocus();
    return Container(
      height: size.height,
      width: size.width,
      child: SafeArea(
        child: Scaffold(
            body: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyTextField(
                size: size,
                focusNode: focusNode1,
                hint: "eg: 01193430D",
                label: "id",
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  size: 40,
                ),
              ),
              SizedBox(height: 40),
              MyTextField(
                size: size,
                focusNode: focusNode2,
                hint: "",
                label: "password",
                prefixIcon: Icon(Icons.password),
              ),
              TextButton(
                onPressed: () {
                  // if (switchControl % 2 == 0)
                  //   FocusScope.of(context).requestFocus(focusNode1);
                  // else
                  // if (focusNode1.hasPrimaryFocus)
                  //   print('textField 1 has focus');
                  // else if (focusNode2.hasPrimaryFocus)
                  //   print('textField 2 has focus');

                  // FocusScopeNode currentFocus = FocusScope.of(context);
                  // if (!currentFocus.hasPrimaryFocus) {
                  //   currentFocus.unfocus();
                  // }

                  // print(new KeyboardVisibilityNotification().isKeyboardVisible);
                  // if (!_keyboardState) FocusScope.of(context).unfocus();

                  // if (focusNode1.hasFocus)
                  //   FocusScope.of(context).requestFocus(focusNode2);
                  // else if (focusNode2.hasFocus)
                  //   FocusScope.of(context).requestFocus(focusNode1);

                  // KeyboardEvent.DOM_KEY_LOCATION_NUMPAD

                  // switchControl++;
                },
                child: Text("switch Focus"),
              ),
              Text(_keyboardState.toString())
            ],
          ),
        )),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key key,
    @required this.size,
    @required this.focusNode,
    @required this.label,
    @required this.hint,
    @required this.prefixIcon,
  }) : super(key: key);

  final Size size;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      child: TextField(
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          // prefix: Container(
          //   height: focusNode,
          // ),
          hintText: hint,
          labelText: label,
          // prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
