import 'package:barter/entity/post.dart';

class PostProvider {
  final int successCode = 200;

  Future<List<Post>> getPosts() async {
    return [
      Post(
          title: 'Laptop',
          description: 'description of the laptop',
          imgUrl:
              'https://image.freepik.com/free-vector/laptop_53876-43924.jpg'),
      Post(
          title: 'Car',
          description: 'description of the car',
          imgUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c4/Muscle_car_img_2490.jpg')
    ];
  }
}
