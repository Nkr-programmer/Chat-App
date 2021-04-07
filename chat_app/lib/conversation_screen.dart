import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/databasee.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Conversation_screen extends StatefulWidget {
  final String chatroomid;

  Conversation_screen( {this.chatroomid });
  
  @override
  _Conversation_screenState createState() => _Conversation_screenState();
}

class _Conversation_screenState extends State<Conversation_screen> {
  TextEditingController messagecontroler=TextEditingController();
 Stream<QuerySnapshot> chatMessageStream;
  Widget ChatMessageList(){
return StreamBuilder(stream:chatMessageStream,
 builder: (context,snapshot){
  return snapshot.hasData? ListView.builder(itemCount:
   snapshot.data.documents.length ,
    itemBuilder: (context,index){
return MessageTile(
 message: snapshot.data.documents[index].data["message"]
,isSendByMe:Constants.myname==snapshot.data.documents[index].data["sendby"
]);
  }):Container();
});
  }
  sendMessages(){
    if(messagecontroler.text.isNotEmpty){
       Map<String,dynamic>messagemap={
      "message":messagecontroler.text,
      "sendby":Constants.myname,
      "time":DateTime.now().millisecondsSinceEpoch
    };
    DatabaseMethods().addconversationmessages(widget.chatroomid,messagemap);
    messagecontroler.text ="";
  }}
  @override
  void initState(){
    DatabaseMethods().getconversationmessages(widget.chatroomid).then((value){
      setState(() {
        chatMessageStream=value;
      });

    });
    super.initState();
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(context),
      body: Container(
        child:Stack(children: <Widget>[ChatMessageList(),
          Container  (
            alignment:Alignment.bottomCenter,
         child:   Container(color: Color(0x54ffffff),
            padding: EdgeInsets.symmetric(horizontal:24,vertical:24),
            child: Row(children:[
              Expanded(
                    child: TextField(
                      controller: messagecontroler,
    style: simpleTextField(),
    decoration:InputDecoration(hintText: "Message",hintStyle: TextStyle(color:Colors.white54),
   border: InputBorder.none 
  )),
              ),
  GestureDetector(onTap: (){
  sendMessages();
  print("fghj");
  },
      child: Container(height:40,width:40,
    decoration:BoxDecoration(gradient: LinearGradient(colors:[ const Color(0xff007EF4),
                                            const Color(0xff2A75BC)] ),  borderRadius: BorderRadius.circular(40)),
    padding: EdgeInsets.all(12),
    child:Image.asset("assets/images/send.png",height:51),
               ),
  ) ]),
            ),
        
        
          ),
        ],)
      ),

      



    );
  }
}
class MessageTile extends StatelessWidget {
final String message;
final bool isSendByMe;
  const MessageTile({this.message, this.isSendByMe}) ;
  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.only(left: isSendByMe ? 0:25,right: isSendByMe ? 25:0),
      width:MediaQuery.of(context).size.width,
      alignment: isSendByMe? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:25,vertical:10),
        decoration: BoxDecoration(
          gradient:LinearGradient(colors:isSendByMe ? [
            const Color(0xff007EF4), const Color(0xff2A75BC)]:
             [const Color(0x1Affffff),      const Color(0x2Affffff)]),
             borderRadius: isSendByMe?BorderRadius.only(topLeft: Radius.circular(25),
             topRight:Radius.circular(25) ,bottomLeft:Radius.circular(25) ):
             BorderRadius.only(topLeft: Radius.circular(25),
             topRight:Radius.circular(25) ,bottomRight:Radius.circular(25) )
        ),
        child: Text(message,style: mediumTextField(),)),
    );
  }
}