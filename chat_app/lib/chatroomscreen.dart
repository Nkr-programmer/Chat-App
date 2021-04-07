import 'package:chat_app/conversation_screen.dart';
import 'package:chat_app/helper/authentication.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/helperfunction.dart';
import 'package:chat_app/search.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/databasee.dart';
import 'package:chat_app/signin.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream  chatroomstream;

Widget chatroomlist(){
  return StreamBuilder(stream:chatroomstream,
   builder: (context,snapshot){
  return snapshot.hasData? ListView.builder(itemCount: 
  snapshot.data.documents.length ,
  shrinkWrap: true,
   itemBuilder: (context,index){
return ChatroomTile(
  userName:snapshot.data.documents[index].data["chatroomid"].toString().replaceAll("_", "")
.replaceAll(Constants.myname, ""),chatroomid:snapshot.data.documents[index].data["chatroomid"]
   ); }):Container();
});
}

  @override
  void initState() {
    // TODO: implement initState
    getuserinfo();

    super.initState();
  }
  getuserinfo()async{
     Constants.myname=await Helperfunction.getUserNameSharedPreference();
     DatabaseMethods().getchatroom(Constants.myname).then((value){
  setState(() {
    chatroomstream=value;

  });
});
    

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
title:Image.asset("assets/images/logo.png",height:51),
actions:[ GestureDetector(onTap: (){
  AuthMethods().signout();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authentication()));
},
    child:   Container(
    padding:EdgeInsets.symmetric(horizontal:16),
    child:Icon(Icons.exit_to_app)
  ),
  
  ),
]),
body:chatroomlist(),
floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute
(builder: (context)=>Search()));}),
);
      
    
  }
}
class ChatroomTile extends StatelessWidget {
final String userName;
final String chatroomid;
  const ChatroomTile( {this.userName, this.chatroomid}) ;


  @override
  Widget build(BuildContext context) {
    return 
       GestureDetector(onTap: (){
Navigator.push(context, MaterialPageRoute
(builder: (context)=>Conversation_screen(chatroomid:chatroomid)));
       },
                child: Container(
           padding: EdgeInsets.symmetric(horizontal:24,vertical:16),
           child: Row(
            children: <Widget>[
              Container(
                height: 40,width:40 ,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff007EF4),
                    
                     borderRadius: BorderRadius.all( Radius.circular(25), )
                ),
                child: Text("${userName.substring(0,1).toUpperCase()}",style: mediumTextField(),)),
                SizedBox(width:8),
                Text(userName,style: mediumTextField(),),
            ],
      ),
         ),
       )
    ;
  }
}