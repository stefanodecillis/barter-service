import 'package:barter/entity/post.dart';

class PostProvider {
  final int successCode = 200;

  Future<List<Post>> getPosts() async {
    return [
      Post(
          id: 0,
          title: 'Laptop',
          author: 'user1',
          description: 'description of the laptop',
          imgUrl:
              'https://image.freepik.com/free-vector/laptop_53876-43924.jpg',
          tags: ['near']),
      Post(
          id: 1,
          title: 'Car',
          author: 'user2',
          description: 'description of the car',
          tags: ['vintage', 'cheaper'],
          imgUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c4/Muscle_car_img_2490.jpg'),
      Post(
          id: 2,
          title: 'Bike',
          description: 'description of the bike',
          author: 'myself',
          tags: ['homemade', 'cheaper'],
          imgUrl:
              'https://images.squarespace-cdn.com/content/v1/59f1f7eeb7411cc456ca7a3c/1578166083482-WJHQSVOL2NO54SK8BQAI/ke17ZwdGBToddI8pDm48kDHPSfPanjkWqhH6pl6g5ph7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0mwONMR1ELp49Lyc52iWr5dNb1QJw9casjKdtTg1_-y4jz4ptJBmI9gQmbjSQnNGng/IMG-1969.jpg'),
      Post(
          id: 3,
          title: 'Housing',
          description: 'description of the housing service',
          author: 'myself',
          tags: ['vintage', 'near'],
          imgUrl:
              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-5811-1569245769.jpg')
    ];
  }

  Future<List<Post>> getUserPosts() async {
    return [
      Post(
          id: 2,
          title: 'Bike',
          description: 'description of the bike',
          tags: ['homemade', 'cheaper'],
          imgUrl:
              'https://images.squarespace-cdn.com/content/v1/59f1f7eeb7411cc456ca7a3c/1578166083482-WJHQSVOL2NO54SK8BQAI/ke17ZwdGBToddI8pDm48kDHPSfPanjkWqhH6pl6g5ph7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0mwONMR1ELp49Lyc52iWr5dNb1QJw9casjKdtTg1_-y4jz4ptJBmI9gQmbjSQnNGng/IMG-1969.jpg'),
      Post(
          id: 3,
          title: 'Housing',
          description: 'description of the housing service',
          tags: ['vintage', 'near'],
          imgUrl:
              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-5811-1569245769.jpg')
    ];
  }
}
