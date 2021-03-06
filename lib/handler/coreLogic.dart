import 'dart:async';
import 'package:barter/event/postEvent.dart';
import 'package:barter/logic/authenticationLogic.dart';
import 'package:barter/logic/postLogic.dart';
import 'package:barter/logic/uploadProcessLogic.dart';

class CoreLogic {
  static final CoreLogic _instance = CoreLogic._privateConstructor();
  // ignore: close_sinks
  PostLogic postLogic;
  UploadProcessLogic uploadProcessLogic;
  AuthenticationLogic authenticationLogic;

  static CoreLogic get instance => _instance;

  // ignore: non_constant_identifier_names
  CoreLogic._privateConstructor() {
    this.postLogic = PostLogic();
    postLogic.add(FetchPosts());
    this.uploadProcessLogic = UploadProcessLogic();
    this.authenticationLogic = AuthenticationLogic();

    //_initTimers();  not perioic
  }

  _initTimers() {
    new Timer.periodic(
        Duration(seconds: 60), (Timer t) => postLogic.add(FetchPosts()));
  }
}
