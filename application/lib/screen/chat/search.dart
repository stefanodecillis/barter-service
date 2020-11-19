import 'dart:convert';

import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {

  String ITEMID;
  Search(String itemID){
    debugPrint(itemID);
    ITEMID=itemID;
  }

  @override
  _SearchState createState() => _SearchState(ITEMID);
}

class _SearchState extends State<Search> {
  _SearchState(String itemid){
    ITEMID=itemid;
  }
  String ITEMID;
  Stream<QuerySnapshot> chats;
  String USERNAME;
  String EMAIL;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      print(searchEditingController.text);
      await databaseMethods.searchByName(searchEditingController.text)
          .then((snapshot){
            print("HEHEHEHEHEHE2");

        searchResultSnapshot = snapshot;

        print(searchResultSnapshot.documents.length);
            print(searchResultSnapshot.documents[0].data);
        USERNAME=searchResultSnapshot.documents[0].data["username"];
        EMAIL=searchResultSnapshot.documents[0].data["email"];
        searchResultSnapshot.documents.forEach((f) => print('${f.data}'));
            print("HEHEHEHEHEHE3");


        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList(){
    return haveUserSearched ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchResultSnapshot.documents.length,
        itemBuilder: (context, index){
        return userTile(
          /*searchResultSnapshot.documents[index].data["userName"],
          searchResultSnapshot.documents[index].data["userEmail"],*/
          USERNAME,EMAIL
        );
        }) : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName, String itemId){
    List<String> users = [HelperFunctions.myName,userName];

    String chatRoomId = getChatRoomId(HelperFunctions.myName,userName,itemId);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chat(
        chatRoomId: chatRoomId,
      )
    ));

  }

  Widget userTile(String userName,String userEmail){
    //print(userName+"asdjkasaskld"+userEmail);
    // userName="Sudarshan";
    // userEmail="de.sudarshan@gmail.com";
    return Container(
      color : Color(0xFF4DB6AC),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              sendMessage(USERNAME,ITEMID);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    );
  }


  getChatRoomId(String a, String b, String c) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$c\_$b\_$a";
    } else {
      return "$a\_$b\_$c";
    }
  }

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks",
          style: TextStyle(
            fontFamily: "tepeno",
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :  Container(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color :  Color(0xFF80CBC4),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      // style: simpleTextStyle(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search Username ...",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),

                        border: InputBorder.none
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png",
                          height: 25, width: 25,)),
                  )
                ],
              ),
            ),
            userList()
          ],
        ),
      ),
    );
  }
}



