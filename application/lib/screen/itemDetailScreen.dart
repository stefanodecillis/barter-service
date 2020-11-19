import 'package:barter/constants.dart';
import 'package:barter/entity/post.dart';
import 'package:barter/event/postEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/logic/postLogic.dart';
import 'package:barter/state/postState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat/search.dart';

class ItemDetailScreen extends StatefulWidget {
  ItemDetailScreen(this.item);
  final Post item;

  @override
  _ItemDetailScreen createState() => _ItemDetailScreen(item);
}

class _ItemDetailScreen extends State<ItemDetailScreen> {
  _ItemDetailScreen(this.item);
  final Post item;

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
            onPressed: () => Search(item.id.toString()),
          )
        ],
      ),
      backgroundColor: secondBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            item.file == null
                ? Image.network(item.imgUrl)
                : Image.file(item.file),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<PostLogic, PostState>(
          cubit: CoreLogic.instance.postLogic,
          builder: (context, state) {
            if(item.insideList(state.userPosts)){
              return FloatingActionButton(
                  onPressed: () {
                    debugPrint('delete');
                    CoreLogic.instance.postLogic.add(DeletePost(post: this.item));
                    Navigator.pop(context);
                  },
                  child:Icon(Icons.delete_forever));
            }
            return FloatingActionButton(
                onPressed: () {
                  debugPrint('love it');
                  CoreLogic.instance.postLogic.add(LovePost(post: this.item));
                },
                child: !item.insideList(state.preferPosts)
                    ? Icon(EvaIcons.heartOutline)
                    : Icon(EvaIcons.heart));
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
