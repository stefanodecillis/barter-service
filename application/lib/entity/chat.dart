import 'package:barter/entity/user.dart';

import 'message.dart';

class Chat {
  String chatRoomId;
  List<User> users;
  List<Message> messages;

  Chat({this.chatRoomId, this.users, this.messages});
}
