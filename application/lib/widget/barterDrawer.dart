import 'package:barter/screen/userPostScreen.dart';
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
                color: Colors.red[500],
                padding: EdgeInsets.all(15),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
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
            ListTile(
              title: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
