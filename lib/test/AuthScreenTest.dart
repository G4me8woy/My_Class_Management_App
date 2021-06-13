// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class AuthScreenTest extends StatefulWidget {
  @override
  _AuthScreenTestState createState() => _AuthScreenTestState();
}

class _AuthScreenTestState extends State<AuthScreenTest> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  KeyboardVisibilityNotification _keyboardVisibilityObj =
      KeyboardVisibilityNotification();

  @override
  void initState() {
    _keyboardVisibilityObj.addNewListener(onChange: (isKeyboardVisible) {
      if (!isKeyboardVisible) {
        setState(() {
          focusNode1.unfocus();
          focusNode2.unfocus();
        });
      }
    });
    super.initState();
  }

  // ignore: todo
  //TODO: recheck relative positioning
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Stack(children: [
            //layout
            Container(
              height: size.height,
              width: size.width,
            ),
            //blue bg
            Positioned(
              right: size.width * 0.26,
              bottom: size.height * 0.29,
              child: SvgPicture.asset(
                'assets/images/circle-cut.svg',
                // color: Theme.of(context).primaryColor,
              ),
            ),
            //logo
            Positioned(
              top: 10,
              left: 10,
              child: SvgPicture.asset('assets/images/logo.svg'),
            ), //sign in txt
            //sign in txt
            Positioned(
              top: 100,
              left: 100,
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            //id text field
            Positioned(
              top: 150,
              left: 10,
              child: MyTextField(
                  size: size,
                  focusNode: focusNode1,
                  label: 'id',
                  hint: 'e.g: 01193430D',
                  prefixPath: 'assets/images/id-logo.svg'),
            ),
            //password field
            Positioned(
              top: 250,
              left: 10,
              child: MyTextField(
                  size: size,
                  focusNode: focusNode2,
                  label: 'password',
                  hint: '',
                  prefixPath: 'assets/images/pass-logo.svg'),
            ),
            //sign in button
            Positioned(
              top: size.height * 0.71,
              left: size.width * 0.2,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xff7B9CF1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 3),
                      blurRadius: 5,
                      spreadRadius: -5,
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),
            //sign up button
            Positioned(
              top: size.height * 0.8,
              left: size.width * 0.38,
              child: TextButton(
                onPressed: () {},
                child: Text('Sign Up'),
              ),
            ),
            //other login options
            Positioned(
              top: size.height * 0.9,
              left: 0,
              child: Container(
                width: size.width,
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/images/fb-logo.svg'),
                    SvgPicture.asset('assets/images/google-logo.svg'),
                    SvgPicture.asset('assets/images/github-logo.svg'),
                  ],
                ),
              ),
            )
          ]),
        ),
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
    @required this.prefixPath,
  }) : super(key: key);

  final Size size;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final String prefixPath;

  //TODO: set textInputAction
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xffD1DEFF),
      ),
      width: size.width * 0.9,
      child: TextField(
        focusNode: focusNode,
        cursorHeight: 25,
        cursorColor: Color(0xff7B9CF1),
        obscureText: label == 'password',
        obscuringCharacter: '*',
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff7B9CF1))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff7B9CF1), width: 2)),
            prefixIcon: SvgPicture.asset(
              prefixPath,
              color: Color(0xff7B9CF1),
              width: size.width * 0.1,
            ),
            hintText: hint,
            labelText: label,
            labelStyle: TextStyle(color: Colors.white, fontSize: 20)
            // prefixIcon: prefixIcon,
            ),
      ),
    );
  }
}
