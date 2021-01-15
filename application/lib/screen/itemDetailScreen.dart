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
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'chat/chat.dart';

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
    return BlocBuilder<PostLogic, PostState>(
        cubit: CoreLogic.instance.postLogic,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: mainTheme,
                actions: [
                  !item.insideList(state.userPosts)?
                  IconButton(
                    icon: Icon(Icons.chat),
                    onPressed: () => sendMessage(item.author,
                        item.id.toString()), //Search(item.id.toString()),
                  ): SizedBox()

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
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.tags.toString().replaceAll('[', "").replaceAll(']', ""),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              floatingActionButton:
              item.insideList(state.userPosts)?
              FloatingActionButton(
                  onPressed: () {
                    debugPrint('delete');
                    CoreLogic.instance.postLogic
                        .add(DeletePost(post: this.item));
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.delete_forever)):
              FloatingActionButton(
                  onPressed: () {
                    debugPrint('love it');
                    CoreLogic.instance.postLogic.add(LovePost(post: this.item));
                  },
                  child: !item.insideList(state.preferPosts)
                      ? Icon(EvaIcons.heartOutline)
                      : Icon(EvaIcons.heart))
          );
        });
  }

  sendMessage(String userName, String itemId) {
    DatabaseMethods databaseMethods = new DatabaseMethods();
    List<String> users = [HelperFunctions.myName, userName];
    debugPrint(HelperFunctions.myName);
    debugPrint(userName);

    String chatRoomId = getChatRoomId(HelperFunctions.myName, userName, itemId);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
      "chatDateTime": DateTime.now().millisecondsSinceEpoch,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                )));
  }

  getChatRoomId(String a, String b, String c) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$c\_$b\_$a";
    } else {
      return "$a\_$b\_$c";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
