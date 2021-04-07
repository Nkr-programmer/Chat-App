import 'package:chat_app/conversation_screen.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/databasee.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
String _myname;
class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchedname= new TextEditingController();
  QuerySnapshot seach;

bool isLoading = false;
bool haveUserSearched= false;
  initiatesearch(){
    if(searchedname.text.isNotEmpty){
      setState(() {
        isLoading= true;
      });
    }
      databaseMethods.getUserByUsername(searchedname.text).then((e){
       
         seach=e;
      setState(() {
        isLoading= false;
        haveUserSearched= true;
      });
        
        
        });
  }
createchartroomandstartconversation(userName){
   String chatRoomId = getChatRoomId(Constants.myname,userName);
   List<String> users = [Constants.myname,userName];

    

    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomid" : chatRoomId,
    };

    databaseMethods.createchatroom(chatRoomId, chatRoomMap);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Conversation_screen(chatroomid:chatRoomId)
    ));

}
  Widget  searchList(){
    return haveUserSearched? ListView.builder(shrinkWrap: true,
      itemCount:seach.documents.length ,
    itemBuilder: (context,index)
    {return SearchTile(
      seach.documents[index].data["name"]
    ,seach.documents[index].data["email"],);
    }):Container();

  }
  Widget SearchTile(String username,String useremail){
    return  Container( padding:EdgeInsets.symmetric(horizontal:16,vertical:16.0), 
      child:Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children:[
          Text(username,style:mediumTextField()),
          Text(useremail,style:mediumTextField())
        ]),
      Spacer(),
     
      GestureDetector(onTap: (){
createchartroomandstartconversation(username);
      },
              child: Container( decoration:BoxDecoration(color:Colors.blue,borderRadius: BorderRadius.circular(20)),
         padding:EdgeInsets.symmetric(horizontal:16,vertical:16.0), 
         child:Text("message"),
         ),
      ) ],)
    );;
  }
    getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(color: Color(0x54ffffff),
            padding: EdgeInsets.symmetric(horizontal:24,vertical:24),
            child: Row(children:[
              Expanded(
                    child: TextField(
                      controller: searchedname,
    style: simpleTextField(),
    decoration:InputDecoration(hintText: "Search UserName...",hintStyle: TextStyle(color:Colors.white54),
   border: InputBorder.none 
  )),
              ),
  GestureDetector(onTap: (){
  initiatesearch();
  },
      child: Container(height:40,width:40,
    decoration:BoxDecoration(gradient: LinearGradient(colors:[ const Color(0xff007EF4),
                                            const Color(0xff2A75BC)] ),  borderRadius: BorderRadius.circular(40)),
    padding: EdgeInsets.all(12),
    child:Image.asset("assets/images/search_white.png",height:51),
               ),
  ) ]),
            ),
      searchList(),    ],
        ),
      ),
    );
  }
}
