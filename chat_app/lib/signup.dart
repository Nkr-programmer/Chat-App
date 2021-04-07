import 'package:chat_app/chatroomscreen.dart';
import 'package:chat_app/helper/helperfunction.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/databasee.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
   final Function toggle;
   SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoad=false;

AuthMethods authMethods= new AuthMethods();
DatabaseMethods  databaseMethods= new DatabaseMethods();

  final formKey =GlobalKey<FormState>();
  TextEditingController username= new TextEditingController();
    TextEditingController email= new TextEditingController();
  TextEditingController password= new TextEditingController();


SignMeUp()async{
if(formKey.currentState.validate()){ 
    setState(() {
    isLoad=true;
  }); 
 await authMethods.signUpWithEmailAndPassword(email.text ,
   password.text).then((val){ print("$val");
   if(val!=null){
  Map<String , String>userMap ={
  "name":username.text,
  "email":email.text,

};
databaseMethods.uploadInfo(userMap);
Helperfunction.saveUserLoggedInSharedPreference(true);
Helperfunction.saveUserEmailSharedPreference(email.text);
Helperfunction.saveUserNameSharedPreference(username.text);
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => ChatRoom()
    ));
   }
  });




}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(context),
      body:  isLoad?Container(child:Center(
    child: CircularProgressIndicator())):
      SingleChildScrollView(
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
          validator: (val){return val.isEmpty||val.length<2?"Please try again new username":null;},
          controller:  username,
          style: simpleTextField(),
          decoration:InputDecorationSet("Username")),
      
    TextFormField(
       validator: (val){return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?null:"Please try new emailId";},
      controller: email,
      style: simpleTextField(),
      decoration:InputDecorationSet("Email")),
     TextFormField(
       obscureText: true,
          validator: (val){return val.length>6?null:"Please try new password";},
       controller: password,
       style: simpleTextField(),
      decoration:InputDecorationSet("Password")
    ),],
    ),
  ),
  SizedBox(height:20.0),
  Container(alignment: Alignment.centerRight,
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Text("Forgot Password?",style: simpleTextField(),),
    ),
  ),
  SizedBox(height: 20.0,),
  GestureDetector(onTap: (){
    SignMeUp();
  },
      child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical:20.0),
      decoration: BoxDecoration(
            gradient:LinearGradient(colors:[ const Color(0xff007EF4),
                                            const Color(0xff2A75BC)] ),
                                            borderRadius: BorderRadius.circular(30)
      ),
      child:Text("Sign Up",style: TextStyle(
        color:Colors.white,fontSize: 17),)
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
    child:Text("Sign Up with Google",style: TextStyle(color:Colors.black,fontSize: 19),)
  ),
  SizedBox(height: 10.0,),
  Row(mainAxisAlignment:MainAxisAlignment.center,children: <Widget>[
    Text("Already have a account?",style: mediumTextField(),),
    GestureDetector(onTap: (){widget.toggle();},
          child: Container(
            padding: EdgeInsets.symmetric(vertical:10.0),
            child: Text("SignIn now",style: TextStyle(color:Colors.white,fontSize: 16.0,
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