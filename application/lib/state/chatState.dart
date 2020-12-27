import 'package:barter/entity/chat.dart';

class ChatState {
  ChatState._();

  List<Chat> chats;

  factory ChatState.initial() {
    return ChatState._()..chats = [];
  }
}
