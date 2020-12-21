import 'package:barter/constants.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:barter/widget/chatroomTile.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    HelperFunctions.myName =
        await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(HelperFunctions.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${HelperFunctions.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondBg,
      appBar: AppBar(
        backgroundColor: mainTheme,
        title: Text(
          "Active chats",
          style: TextStyle(
            fontFamily: "tepeno",
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: chatRoomsList(),
      ),
    );
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData &&
                snapshot.data.documents.length > 0 &&
                HelperFunctions.myName != null
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  debugPrint("2...." +
                      snapshot.data.documents[index].data['chatRoomId']
                          .toString());
                  return Container(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: ChatRoomsTile(
                      userName: snapshot
                          .data.documents[index].data['chatRoomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(HelperFunctions.myName, ""),
                      chatRoomId:
                          snapshot.data.documents[index].data["chatRoomId"],
                    ),
                  );
                })
            : Container(
                child: Center(
                  child: Text("No Chats to here :("),
                ),
              );
      },
    );
  }
}
