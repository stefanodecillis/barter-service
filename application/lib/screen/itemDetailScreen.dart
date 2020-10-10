import 'package:barter/constants.dart';
import 'package:barter/entity/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen(this.item);
  final Post item;

  @override
  _ItemDetailScreen createState() => _ItemDetailScreen(item);
}

class _ItemDetailScreen extends State<ItemDetailScreen> {
  _ItemDetailScreen(this.item);
  final Post item;
  bool liked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () => debugPrint("open chat with the seller"),
          )
        ],
      ),
      backgroundColor: secondBg,
      body: Column(
        children: [
          Image.network(item.imgUrl),
          Text(item.title),
          Text(item.description),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('love it');
          setState(() {
            this.liked = !this.liked;
          });
        },
        child: !this.liked ? Icon(EvaIcons.heartOutline) : Icon(EvaIcons.heart),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
