import 'package:barter/event/postEvent.dart';
import 'package:barter/repository/postRepository.dart';
import 'package:barter/state/postState.dart';
import 'package:barter/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostLogic extends Bloc<PostEvent, PostState> {
  PostLogic() : super(PostState.initial());

  @override
  PostState get initialState => PostState.initial();

  PostRepository _repository = new PostRepository();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is FetchPosts) {
      PostState ss = generateState(state);
      ss.posts = await _repository.getPosts();
      yield ss;
      ss.userPosts = await _repository.getUserPosts();
      yield ss;
    } else if (event is FetchFilter) {
      PostState ss = generateState(state);
      if (event.pattern == '')
        yield ss;
      else {
        ss.filtered = true;
        ss.filteredPosts = filterList(ss.posts, event.pattern);
        yield ss;
      }
    } else if (event is RestoreResult) {
      PostState ss = generateState(state);
      ss.filtered = false;
      ss.filteredPosts = [];
      yield ss;
    } else if (event is AddPost) {
      PostState ss = generateState(state);
      ss.userPosts.add(event.post);
      yield ss;
    } else if (event is LovePost){
      PostState ss = generateState(state);
      if(event.post.insideList(ss.preferPosts)){
        ss.preferPosts.remove(event.post);
      } else {
        ss.preferPosts.add(event.post);
      }
      yield ss;
    } else if (event is DeletePost){
      PostState ss = generateState(state);
      ss.userPosts = event.post.deleteFromList(ss.userPosts);
      ss.posts = event.post.deleteFromList(ss.posts);
      yield ss;
    }
  }
  

  PostState generateState(PostState state) {
    PostState ss = PostState.initial();
    ss.posts = state.posts;
    ss.filtering = state.filtering;
    ss.filtered = state.filtered;
    ss.filteredPosts = state.filteredPosts;
    ss.userPosts = state.userPosts;
    ss.preferPosts = state.preferPosts;
    return ss;
  }
}
