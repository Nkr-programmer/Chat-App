import 'package:chat_app/chatroomscreen.dart';
import 'package:chat_app/helper/authentication.dart';
import 'package:flutter/material.dart';
import 'helper/helperfunction.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
   void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await Helperfunction.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        primarySwatch: Colors.blue,
scaffoldBackgroundColor: Color(0xff1F1F1F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authentication()
          : Container(
        child: Center(
          child: Authentication(),
        ),
      ),
    );
  }
}
