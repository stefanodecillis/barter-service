import 'package:barter/entity/intersection.dart';

class IntersectionState {
  IntersectionState._();

  bool filtering;
  bool filtered;
  List<Intersection> intersections;
  List<Intersection> filteredIntersections;

  factory IntersectionState.initial() {
    return IntersectionState._()
      ..intersections = []
      ..filtering = false
      ..filtered = false
      ..filteredIntersections = [];
  }
}
