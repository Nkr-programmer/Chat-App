import 'package:shared_preferences/shared_preferences.dart';

class Helperfunction{

static String sharedpreferenceUserLogedInkey= "ISLOGGEDIN";
static String sharedpreferenceUserNamekey= "USERNAMEKEY";
static String sharedpreferenceUserEmailkey= "USERMAILKEY";

static Future<bool> saveUserLoggedInSharedPreference(
  bool isUserLoggedIn)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setBool(sharedpreferenceUserLogedInkey,isUserLoggedIn);
  }

static Future<bool> saveUserNameSharedPreference(
  String username)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceUserNamekey,username);
  }
static Future<bool> saveUserEmailSharedPreference(
  String userEmail)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(sharedpreferenceUserEmailkey,userEmail);
  }




static Future<bool> getUserLoggedInSharedPreference()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getBool(sharedpreferenceUserLogedInkey);
  }

static Future<String> getUserNameSharedPreference()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getString(sharedpreferenceUserNamekey);
  }
static Future<String> getUserEmailSharedPreference()async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.getString(sharedpreferenceUserEmailkey);
  }

}