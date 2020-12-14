import 'package:barter/constants.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/screen/chat/chat.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {

    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData  && snapshot.data.documents.length>0 && HelperFunctions.myName != null
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  debugPrint("2...."+snapshot.data.documents[index].data['chatRoomId'].toString());
                  return ChatRoomsTile(

                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(HelperFunctions.myName, ""),

                    chatRoomId: snapshot.data.documents[index].data["chatRoomId"],

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

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    HelperFunctions.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(HelperFunctions.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${HelperFunctions.myName}");
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
        /*actions: [
          GestureDetector(
            onTap: () {
              //AuthService().signOut();
              CoreLogic.instance.authenticationLogic.add(Logout());
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],*/
      ),
      body: Container(
        child: chatRoomsList(),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search("ITEMID")));
        },
      ),*/
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chat(
            chatRoomId: chatRoomId,
          )
        ));
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
                  color: mainTheme,
                  borderRadius: BorderRadius.circular(30)),
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
              )
            ),
            SizedBox(
              width: 15,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}
