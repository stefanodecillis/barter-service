import 'package:barter/entity/post.dart';
import 'package:flutter/cupertino.dart';

List<Post> filterList(List<Post> list, String pattern) {
  List<Post> res = [];
  for (Post i in list) {
    if (i.title.toLowerCase().contains(pattern.toLowerCase())) {
      res.add(i);
      debugPrint(i.title);
    }
  }

  return res;
}
