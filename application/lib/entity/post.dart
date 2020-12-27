import 'dart:io';

class Post {
  int id;
  String title;
  String author;
  String description;
  String imgUrl;
  File file; // user1_user2_itemid
  List<String> tags = [];

  Post(
      {this.id,
      this.title,
      this.description,
      this.imgUrl,
      this.author,
      this.tags});
  Post.file(
      {this.title,
      this.description,
      this.file,
      this.author = 'myself',
      this.tags});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imgUrl'] = this.imgUrl;
    return data;
  }

  bool insideList(List<Post> list) {
    for (Post element in list) {
      if (element.title == this.title &&
          element.description == this.description) {
        return true;
      }
    }
    return false;
  }

  List<Post> deleteFromList(List<Post> list) {
    for (Post element in list) {
      if (element.title == this.title &&
          element.description == this.description) {
        list.remove(element);
        return list;
      }
    }
    return list;
  }

  bool hasTag(String tag) {
    for (String intag in this.tags) {
      if (intag.toLowerCase() == tag.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
