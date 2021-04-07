import 'package:chat_app/signin.dart';
import 'package:chat_app/signup.dart';
import 'package:flutter/widgets.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn=true;
  void toggle(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn)
  return Signin(toggle);
  else
  return SignUp(toggle);
  }
}