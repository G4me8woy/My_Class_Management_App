// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreen createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  bool isSignIn = false;

  KeyboardVisibilityNotification _keyboardVisibilityObj =
      KeyboardVisibilityNotification();

  @override
  void initState() {
    _keyboardVisibilityObj.addNewListener(onChange: (isKeyboardVisible) {
      if (!isKeyboardVisible) {
        setState(() {
          focusNode1.unfocus();
          focusNode2.unfocus();
          focusNode3.unfocus();
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Stack(children: [
              //layout
              Container(
                height: size.height,
                width: size.width,
              ),
              //blue bg
              AnimatedPositioned(
                // right: size.width * 0.26,
                // bottom: size.height * 0.29,
                right: isSignIn ? size.width * 0.26 : size.width * -1.3,
                bottom: isSignIn ? size.height * 0.29 : size.height * -0.42,
                duration: Duration(seconds: 1),
                child: SvgPicture.asset(
                  'assets/images/circle-full.svg',
                  // color: Theme.of(context).primaryColor,
                ),
              ),
              //logo
              Positioned(
                top: 10,
                left: 10,
                child: SvgPicture.asset(
                  isSignIn
                      ? 'assets/images/logo.svg'
                      : 'assets/images/logo-blue.svg',
                ),
              ), //sign in txt
              //sign in txt
              Positioned(
                top: 100,
                left: 100,
                child: AnimatedDefaultTextStyle(
                  child: Text(isSignIn ? 'Sign In' : 'Sign Up'),
                  style: isSignIn
                      ? TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        )
                      : TextStyle(
                          fontSize: 40,
                          color: Color(0xff7B9CF1),
                        ),
                  duration: Duration(seconds: 1),
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
                top: 240,
                left: 10,
                child: MyTextField(
                    size: size,
                    focusNode: focusNode2,
                    label: 'password',
                    hint: '',
                    prefixPath: 'assets/images/pass-logo.svg'),
              ),
              //contact field
              Positioned(
                top: 330,
                left: 10,
                child: AnimatedOpacity(
                  opacity: isSignIn ? 0 : 1,
                  duration: Duration(seconds: 1),
                  alwaysIncludeSemantics: false,
                  child: MyTextField(
                    size: size,
                    focusNode: focusNode3,
                    label: 'contact',
                    hint: '',
                    prefixPath: 'assets/images/phone-logo.svg',
                    isEnabled: isSignIn ? false : true,
                  ),
                ),
              ),
              //sign in button
              Positioned(
                top: size.height * 0.65,
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
                      isSignIn ? 'Sign In' : 'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
              //sign up button
              Positioned(
                top: size.height * 0.75,
                left: size.width * 0.38,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isSignIn = !isSignIn;
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    child: isSignIn ? Text('Sign Up') : Text('Sign In'),
                    style: isSignIn
                        ? TextStyle(color: Color(0xff7B9CF1))
                        : TextStyle(color: Colors.white),
                    duration: Duration(seconds: 1),
                  ),
                ),
              ),
              //other login options
              Positioned(
                top: size.height * 0.85,
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
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField(
      {Key key,
      @required this.size,
      @required this.focusNode,
      @required this.label,
      @required this.hint,
      @required this.prefixPath,
      this.isEnabled})
      : super(key: key);

  final Size size;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final String prefixPath;
  bool isEnabled;

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
        enabled: isEnabled == null ? true : isEnabled,
        focusNode: focusNode,
        keyboardType:
            label == 'contact' ? TextInputType.number : TextInputType.text,
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
            prefixIcon: Padding(
              padding: label == 'contact'
                  ? const EdgeInsets.all(8.0)
                  : const EdgeInsets.all(0),
              child: SvgPicture.asset(
                prefixPath,
                color: Color(0xff7B9CF1),
                width: 40,
              ),
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
