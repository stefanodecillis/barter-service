import 'package:barter/constants.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/widget/chatroomTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    DatabaseMethods.getUserChats(HelperFunctions.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
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
          child:
              /* BlocBuilder<ChatLogic, ChatState>(
          cubit: CoreLogic.instance.chatLogic,
          builder: (context, state) {
            if (state.chats.length == 0) {
              return Container(
                child: Center(
                  child: Text("No Chats to here :("),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                for (Message message in state.chats[index].messages) {
                  print(message.message);
                }
                return ChatRoomsTile(
                    chatRoomId: state.chats[index].chatRoomId,
                    userName: state.chats[index].users[1].uid,
                    lastMsg: state.chats[index]
                        .messages[state.chats[index].messages.length - 1]);
              },
            );
          },
        ), */
              chatRoomsList()),
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
