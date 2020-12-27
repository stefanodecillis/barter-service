import 'package:barter/entity/message.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatRoomsTile extends StatefulWidget {
  ChatRoomsTile({this.userName, @required this.chatRoomId, this.lastMsg});
  final String userName;
  final String chatRoomId;
  final Message lastMsg;

  @override
  _ChatRoomsTileState createState() => _ChatRoomsTileState(
      userName: userName, chatRoomId: chatRoomId, lastMsg: lastMsg);
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  final String userName;
  final String chatRoomId;
  final Message lastMsg;
  Stream chat;

  _ChatRoomsTileState({this.userName, @required this.chatRoomId, this.lastMsg});

  getChat() async {
    DatabaseMethods.getChats(chatRoomId).then((value) {
      setState(() {
        chat = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getChat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        color: secondTheme,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: mainTheme, borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Text(userName.substring(0, 1),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w300))
                  ],
                )),
            SizedBox(
              width: 15,
            ),
            Container(
              child: Column(
                children: [
                  Text(userName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 20,
                    child: StreamBuilder(
                      stream: chat,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot
                              .data
                              .documents[snapshot.data.documents.length - 1]
                              .data['message']);
                          return Text(
                              snapshot
                                  .data
                                  .documents[snapshot.data.documents.length - 1]
                                  .data['message'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'OverpassRegular',
                                  fontWeight: FontWeight.w300));
                        }
                        return Text('');
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
