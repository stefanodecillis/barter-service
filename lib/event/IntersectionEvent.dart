abstract class IntersectionEvent {}

class FetchIntersections extends IntersectionEvent {}

class SearchEvent extends IntersectionEvent {}

class FetchFilter extends IntersectionEvent {
  final String pattern;
  FetchFilter(this.pattern);
}

class RestoreResult extends IntersectionEvent {}
