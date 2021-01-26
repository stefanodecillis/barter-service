import 'package:barter/entity/post.dart';

class PostProvider {
  final int successCode = 200;

  Future<List<Post>> getPosts() async {
    return [
      Post(
          id: 0,
          title: 'Laptop',
          author: 'user1',
          description: 'A laptop or laptop computer, is a small, portable personal computer (PC) with a "clamshell" form factor, typically having a thin LCD or LED computer screen mounted on the inside of the upper lid of the clamshell and an alphanumeric keyboard on the inside of the lower lid. The clamshell is opened up to use the computer. Laptops are folded shut for transportation, and thus are suitable for mobile use.[1] Its name comes from lap, as it was deemed to be placed on a person\'s lap when being used. Although originally there was a distinction between laptops and notebooks (the former being bigger and heavier than the latter), as of 2014, there is often no longer any difference. Today, laptops are commonly used in a variety of settings, such as at work, in education, for playing games, web browsing, for personal multimedia, and general home computer use.',
          imgUrl:
              'https://image.freepik.com/free-vector/laptop_53876-43924.jpg',
          tags: ['near']),
      Post(
          id: 1,
          title: 'Car',
          author: 'user2',
          description: 'A car (or automobile) is a wheeled motor vehicle used for transportation. Most definitions of cars say that they run primarily on roads, seat one to eight people, have four wheels, and mainly transport people rather than goods',
          tags: ['vintage', 'cheaper','motor'],
          imgUrl:
              'https://upload.wikimedia.org/wikipedia/commons/c/c4/Muscle_car_img_2490.jpg'),
      Post(
          id: 2,
          title: 'Bike',
          description: 'A bicycle, also called a bike or cycle, is a human-powered or motor-powered, pedal-driven, single-track vehicle, having two wheels attached to a frame, one behind the other. A bicycle rider is called a cyclist, or bicyclist.\n\n  Although bike and cycle are used interchangeably to refer mostly to two types of two-wheelers the terms still vary across the world. In India for example a cycle refers only to a two-wheeler using pedal power whereas the term bike is used to describe a two-wheeler using internal combustion engine or electric motors as a source of motive power instead of motorcycle/motorbike.',
          author: 'myself',
          tags: ['homemade', 'cheaper'],
          imgUrl:
              'https://images.squarespace-cdn.com/content/v1/59f1f7eeb7411cc456ca7a3c/1578166083482-WJHQSVOL2NO54SK8BQAI/ke17ZwdGBToddI8pDm48kDHPSfPanjkWqhH6pl6g5ph7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0mwONMR1ELp49Lyc52iWr5dNb1QJw9casjKdtTg1_-y4jz4ptJBmI9gQmbjSQnNGng/IMG-1969.jpg'),
      Post(
          id: 3,
          title: 'Housing',
          description: 'Housing, or more generally living spaces, refers to the construction and assigned usage of houses or buildings collectively, for the purpose of sheltering people — the planning or provision delivered by an authority, with related meanings. The social issue is of ensuring that members of society have a home in which to live, whether this is a house, or some other kind of dwelling, lodging, or shelter. Many governments have one or more housing authorities, sometimes also called a housing ministry, or housing department.',
          author: 'myself',
          tags: ['vintage', 'near'],
          imgUrl:
              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-5811-1569245769.jpg'),
      Post(
          id: 4,
          title: 'Desk',
          author: 'user3',
          description: 'A desk or bureau is a piece of furniture with a flat table-style work surface used in a school, office, home or the like for academic, professional or domestic activities such as reading, writing, or using equipment such as a computer. ... Some people use standing desks to be able to stand while using them.',
          tags: ['cheaper','wood', "deliverable"],
          imgUrl:
          'https://images.eq3.com/image-service/78f4d56d-5427-11ea-966f-0af5f9f3b9c4/COMPRESSED.jpg'),
    ];
  }

  Future<List<Post>> getUserPosts() async {
    return [
      Post(
          id: 2,
          title: 'Bike',
          description: 'A bicycle, also called a bike or cycle, is a human-powered or motor-powered, pedal-driven, single-track vehicle, having two wheels attached to a frame, one behind the other. A bicycle rider is called a cyclist, or bicyclist.\n\n  Although bike and cycle are used interchangeably to refer mostly to two types of two-wheelers the terms still vary across the world. In India for example a cycle refers only to a two-wheeler using pedal power whereas the term bike is used to describe a two-wheeler using internal combustion engine or electric motors as a source of motive power instead of motorcycle/motorbike.',
          tags: ['homemade', 'cheaper'],
          imgUrl:
              'https://images.squarespace-cdn.com/content/v1/59f1f7eeb7411cc456ca7a3c/1578166083482-WJHQSVOL2NO54SK8BQAI/ke17ZwdGBToddI8pDm48kDHPSfPanjkWqhH6pl6g5ph7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0mwONMR1ELp49Lyc52iWr5dNb1QJw9casjKdtTg1_-y4jz4ptJBmI9gQmbjSQnNGng/IMG-1969.jpg'),
      Post(
          id: 3,
          title: 'Housing',
          description: 'Housing, or more generally living spaces, refers to the construction and assigned usage of houses or buildings collectively, for the purpose of sheltering people — the planning or provision delivered by an authority, with related meanings. The social issue is of ensuring that members of society have a home in which to live, whether this is a house, or some other kind of dwelling, lodging, or shelter. Many governments have one or more housing authorities, sometimes also called a housing ministry, or housing department.',
          tags: ['vintage', 'near'],
          imgUrl:
              'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/img-5811-1569245769.jpg')
    ];
  }
}
