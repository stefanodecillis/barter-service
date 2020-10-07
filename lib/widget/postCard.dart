import 'package:barter/constants.dart';
import 'package:barter/entity/post.dart';
import 'package:barter/screen/itemDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  PostCard({this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: secondBg,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: double.maxFinite,
        child: Row(children: [
          SizedBox(
            width: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Image.network(
              post.imgUrl,
              height: 140,
              width: 140,
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(post.description),
            ],
          ),
          Spacer()
        ]),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailScreen(this.post)));
      },
    );
  }
}
