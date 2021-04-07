import 'package:flutter/material.dart';

Widget AppBar1(BuildContext context){
  return AppBar(
    title: Image.asset("assets/images/logo.png",height:51),
  );
}
InputDecoration InputDecorationSet(String text){
  return InputDecoration(hintText: text,hintStyle: TextStyle(color:Colors.white54),focusedBorder:UnderlineInputBorder(
      borderSide:BorderSide(color: Colors.white)
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide:BorderSide(color: Colors.blueAccent)
    ),
  );

}
TextStyle simpleTextField(){
  return TextStyle(color:Colors.white,fontSize: 15.0);
}

TextStyle mediumTextField(){
  return TextStyle(color:Colors.white,fontSize: 16.0);
}