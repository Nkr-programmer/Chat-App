import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username){
return  Firestore.instance.collection("users")
.where("name",isEqualTo:username).getDocuments().catchError((e)
    {print(e.toString());});
  }
    getUserByEmail(String useremail){
return  Firestore.instance.collection("users")
.where("email",isEqualTo:useremail).getDocuments().catchError((e)
    {print(e.toString());});
  }
  uploadInfo(userMap){
    Firestore.instance.collection("users")
.add(userMap).catchError((e){print(e.toString());});
  }
 Future<bool> createchatroom(String chatroomid,chatroommap){
    Firestore.instance.collection("chatroom").document
    (chatroomid).setData(chatroommap).catchError((e)
    {print(e.toString());});
  }
  Future<void> addconversationmessages(String chatroomid,messagemap){
Firestore.instance.collection("chatroom")
.document(chatroomid).collection("chats").add(messagemap).catchError((e){print(e.toString());});
  }
 
   getconversationmessages(String chatroomid)async{
    return  Firestore.instance.collection("chatroom")
.document(chatroomid).collection("chats").orderBy("time",
descending:false).snapshots();}
  
  getchatroom(String userName)async{
    return await Firestore.instance.collection("chatroom").
    where("users",arrayContains: userName).snapshots();
  }
}