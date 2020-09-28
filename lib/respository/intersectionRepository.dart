import 'package:barter/entity/intersection.dart';
import 'package:barter/provider/intersectionProvider.dart';

class IntersectionRepository {
  IntersectionProvider _intersectionProvider = new IntersectionProvider();

  Future<List<Intersection>> getIntersections() =>
      _intersectionProvider.getIntersections();
}
