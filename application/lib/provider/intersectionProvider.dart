import 'package:barter/entity/intersection.dart';

class IntersectionProvider {
  final int successCode = 200;

  Future<List<Intersection>> getIntersections() async {
    return [
      Intersection(
          title: 'Laptop',
          description: 'description of the laptop',
          imgUrl:
              'https://image.freepik.com/free-vector/laptop_53876-43924.jpg'),
      Intersection(
          title: 'Car',
          description: 'description of the car',
          imgUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c4/Muscle_car_img_2490.jpg')
    ];
  }
}
