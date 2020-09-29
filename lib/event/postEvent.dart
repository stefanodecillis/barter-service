abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class SearchEvent extends PostEvent {}

class FetchFilter extends PostEvent {
  final String pattern;
  FetchFilter(this.pattern);
}

class RestoreResult extends PostEvent {}
