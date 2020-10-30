import 'package:barter/entity/post.dart';

class PostState {
  PostState._();

  bool filtering;
  bool filtered;
  List<Post> posts;
  List<Post> filteredPosts;
  List<Post> userPosts;
  List<Post> preferPosts;

  factory PostState.initial() {
    return PostState._()
      ..posts = []
      ..filtering = false
      ..filtered = false
      ..filteredPosts = []
      ..userPosts = []
      ..preferPosts = [];
  }
}
