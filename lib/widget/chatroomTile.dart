import 'package:barter/provider/database.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatRoomsTile extends StatefulWidget {
  ChatRoomsTile({this.userName, @required this.chatRoomId});
  final String userName;
  final String chatRoomId;

  @override
  _ChatRoomsTileState createState() =>
      _ChatRoomsTileState(userName: userName, chatRoomId: chatRoomId);
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  final String userName;
  final String chatRoomId;
  Stream chat;

  _ChatRoomsTileState({this.userName, @required this.chatRoomId});

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
        margin: EdgeInsets.only(left: 5, right: 5),
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        height: 90,
        decoration: BoxDecoration(
            color: secondTheme, borderRadius: BorderRadius.circular(20)),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 30,
                    child: Text(userName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                                  fontSize: 15,
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
