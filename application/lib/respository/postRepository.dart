import 'package:barter/entity/post.dart';
import 'package:barter/provider/postProvider.dart';

class PostRepository {
  PostProvider _postProvider = new PostProvider();

  Future<List<Post>> getPosts() => _postProvider.getPosts();
}
