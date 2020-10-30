import 'package:barter/entity/post.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class SearchEvent extends PostEvent {}

class FetchFilter extends PostEvent {
  final String pattern;
  FetchFilter(this.pattern);
}

class RestoreResult extends PostEvent {}

class AddPost extends PostEvent {
  final Post post;
  AddPost(this.post);
}

class FetchPreferPosts extends PostEvent {}

class LovePost extends PostEvent {
  final Post post;
  LovePost({this.post});
}