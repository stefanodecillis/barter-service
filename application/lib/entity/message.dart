import 'package:barter/entity/user.dart';

class Message {
  String message;
  User sendBy;
  BigInt time;

  Message(message, sendBy, time);
}
