import 'package:barter/entity/chat.dart';
import 'package:barter/entity/message.dart';
import 'package:barter/entity/user.dart';
import 'package:barter/event/chatEvent.dart';
import 'package:barter/handler/helperfunctions.dart';
import 'package:barter/provider/database.dart';
import 'package:barter/state/chatState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatLogic extends Bloc<ChatEvent, ChatState> {
  ChatLogic() : super(ChatState.initial());

  @override
  ChatState get initialState => ChatState.initial();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is FetchChat) {
      ChatState ss = generateState(state);
      List<Chat> chats = [];
      String uid = await HelperFunctions.getUserNameSharedPreference();
      var chatlist = await DatabaseMethods.getUserChats(uid);

      chatlist.forEach((chat) async {
        List<Map<String, dynamic>> chatMapList =
            chat.documents.map((DocumentSnapshot doc) {
          return doc.data;
        }).toList();

        for (Map<String, dynamic> chat in chatMapList) {
          String chatRoomId = chat["chatRoomId"];
          List<User> users = [];
          for (String username in chat['users']) {
            users.add(User(uid: username));
          }
          int chatDateTime = chat[
              'chatDateTime']; //not added since they respect the order from the query
          List<Message> messages = [];
          var msgSnapshots = await DatabaseMethods.getChats(chatRoomId);
          msgSnapshots.forEach((messagesSnap) {
            List<Map<String, dynamic>> messageList =
                messagesSnap.documents.map((DocumentSnapshot doc) {
              return doc.data;
            }).toList();

            for (Map<String, dynamic> message in messageList) {
              print(message['message']);
              messages.add(Message(message['message'],
                  User(uid: message['sendBy']), message['time']));
            }
          });
          chats.add(Chat(
              messages: [Message("message", User(uid: "ncjdcn"), 1312342)],
              chatRoomId: chatRoomId,
              users: users));
          print('--> ' + chats.length.toString());
        }
      });

      ss.chats = chats;
      print('--> ' + chats.length.toString());
      yield ss;
    }
  }

  ChatState generateState(ChatState state) {
    ChatState ss = ChatState.initial();
    ss.chats = state.chats;
    return ss;
  }
}
