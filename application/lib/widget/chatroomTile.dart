import 'package:barter/screen/chat/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

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
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'OverpassRegular',
<<<<<<< HEAD
                    fontWeight: FontWeight.w300)),
            Text("last message",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'OverpassRegular',
=======
>>>>>>> b928afc7ad003675ab9556b5b9f2441532137711
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
