import 'package:chat_app/chatroomscreen.dart';
import 'package:chat_app/helper/helperfunction.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/databasee.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Signin extends StatefulWidget {
   final Function toggle;
   Signin(this.toggle);
   @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
   final formKey =GlobalKey<FormState>();
   AuthMethods authMethods= new AuthMethods();
     TextEditingController email= new TextEditingController();
  TextEditingController password= new TextEditingController();
bool isLoading= false;
  Signin()async{ 
    if(formKey.currentState.validate()){
    setState(() {
   isLoading=true;

 });  



 await authMethods.signInWithEmailAndPassword(
   email.text, password.text).then((val)async
 {if(val!=null){
  QuerySnapshot snapshotUser=await DatabaseMethods().getUserByEmail(email.text);
    Helperfunction.saveUserLoggedInSharedPreference(true);
     Helperfunction.saveUserNameSharedPreference(snapshotUser.documents[0].data["name"]);
 Helperfunction.saveUserEmailSharedPreference(
     snapshotUser.documents[0].data["email"]);
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => ChatRoom()
    ));
 }
 else{
   setState(() {
     isLoading=false;
   });
 }
 } );

}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(context),
      body:SingleChildScrollView(
              child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height-50,
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
children: <Widget>[
  Form(
       key: formKey,
      child: Column(
      children: <Widget>[
        TextFormField(
       validator: (val){return 
       RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?null:"Please try new emailId";},
          controller: email,
          style: simpleTextField(),
          decoration:InputDecorationSet("Email")),
      ],
    ),
  ),
   TextFormField(
       obscureText: true,
          validator: (val){return val.length>6?null:"Please try new password";},
     controller: password,
     style: simpleTextField(),
    decoration:InputDecorationSet("Password")
  ),
  SizedBox(height:20.0),
  Container(alignment: Alignment.centerRight,
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Text("Forgot Password?",style: simpleTextField(),),
    ),
  ),
  SizedBox(height: 20.0,),
  GestureDetector(onTap:(){
    Signin();
  }
,      child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical:20.0),
      decoration: BoxDecoration(
            gradient:LinearGradient(colors:[ const Color(0xff007EF4),
                                            const Color(0xff2A75BC)] ),
                                            borderRadius: BorderRadius.circular(30)
      ),
      child:Text("Sign In",style: TextStyle(color:Colors.white,fontSize: 17),)
    ),
  ),

  SizedBox(height: 20.0,),
  Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical:20.0),
    decoration: BoxDecoration(
          gradient:LinearGradient(colors:[ const Color(0xffffffff),
                                          const Color(0xfffffffB)] ),
                                          borderRadius: BorderRadius.circular(30)
    ),
    child:Text("Sign in with Google",style: TextStyle(color:Colors.black,fontSize: 19),)
  ),
  SizedBox(height: 10.0,),
  Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
    Text("Dont have a account?",style: mediumTextField(),),
    GestureDetector(onTap: (){widget.toggle();},
          child: Container(
        padding: EdgeInsets.symmetric(vertical:10.0),
        child: Text("Registor now",style: TextStyle(color:Colors.white,fontSize: 16.0,
        decoration: TextDecoration.underline,
        ),),
      ),
    ),

  ],),
  SizedBox(height: 50.0,),
],
               
            ),
         
          ),
          
        ),
      )
    );
  }
}
