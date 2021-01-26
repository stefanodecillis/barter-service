import 'package:barter/constants.dart';
import 'package:barter/event/AuthenticationEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/screen/chat/chatrooms.dart';
import 'package:barter/screen/preferPostScreen.dart';
import 'package:barter/screen/userPostScreen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarterDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[300],
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                color: mainTheme,
                padding: EdgeInsets.all(25),
                child: Container(
                  decoration:
                      BoxDecoration(color: mainBg, shape: BoxShape.circle),
                  child: Icon(EvaIcons.person,size: 50,)
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPostScreen()),
                );
              },
              child: ListTile(
                title: Text('My items'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreferPostScreen()),
                );
              },
              child: ListTile(
                title: Text('Love items'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatRoom()),
                );
              },
              child: ListTile(
                title: Text('Active chats'),
              ),
            ),
            GestureDetector(
              onTap: () {
                CoreLogic.instance.authenticationLogic.add(Logout());
              },
              child: ListTile(
                title: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
