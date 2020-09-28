import 'dart:async';

import 'package:barter/event/IntersectionEvent.dart';
import 'package:barter/logic/IntersectionLogic.dart';

class CoreLogic {
  static final CoreLogic _instance = CoreLogic._privateConstructor();
  // ignore: close_sinks
  IntersectionLogic intersectionLogic;

  static CoreLogic get instance => _instance;

  // ignore: non_constant_identifier_names
  CoreLogic._privateConstructor() {
    this.intersectionLogic = IntersectionLogic();
    intersectionLogic.add(FetchIntersections());
    //_initTimers();  not perioic
  }

  _initTimers() {
    new Timer.periodic(Duration(seconds: 60),
        (Timer t) => intersectionLogic.add(FetchIntersections()));
  }
}
