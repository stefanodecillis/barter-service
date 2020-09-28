import 'package:barter/entity/intersection.dart';
import 'package:flutter/cupertino.dart';

List<Intersection> filterList(List<Intersection> list, String pattern) {
  List<Intersection> res = [];
  for (Intersection i in list) {
    if (i.title.toLowerCase().contains(pattern.toLowerCase())) {
      res.add(i);
      debugPrint(i.title);
    }
  }

  return res;
}
