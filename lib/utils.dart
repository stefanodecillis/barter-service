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

List<Post> filterTagsList(List<Post> list, List<String> tags) {
  if (tags.length == 0) {
    return list;
  }
  List<Post> res = [];
  for (Post i in list) {
    i.tags.forEach((tag) {
      if (tags.contains(tag) && !res.contains(i)) {
        debugPrint(i.title);
        res.add(i);
      }
    });
  }

  return res;
}
