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
              'https://upload.wikimedia.org/wikipedia/commons/c/c4/Muscle_car_img_2490.jpg'),
      Post(
          title: 'Bike',
          description: 'description of the bike',
          imgUrl:
              'https://images.squarespace-cdn.com/content/v1/59f1f7eeb7411cc456ca7a3c/1578166083482-WJHQSVOL2NO54SK8BQAI/ke17ZwdGBToddI8pDm48kDHPSfPanjkWqhH6pl6g5ph7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0mwONMR1ELp49Lyc52iWr5dNb1QJw9casjKdtTg1_-y4jz4ptJBmI9gQmbjSQnNGng/IMG-1969.jpg'),
      Post(
          title: 'Housing',
          description: 'description of the housing service',
          imgUrl:
              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-5811-1569245769.jpg')
    ];
  }
}
