import 'package:barter/entity/post.dart';
import 'package:barter/event/postEvent.dart';
import 'package:barter/event/uploadProcessEvent.dart';
import 'package:barter/handler/coreLogic.dart';
import 'package:barter/provider/imageRecognitionProvider.dart';
import 'package:barter/state/uploadProcessState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadProcessLogic extends Bloc<UploadProcessEvent, UploadProcessState> {
  UploadProcessLogic() : super(UploadProcessState.initial());

  @override
  UploadProcessState get initialState => UploadProcessState.initial();

  @override
  Stream<UploadProcessState> mapEventToState(UploadProcessEvent event) async* {
    if (event is UploadPicture) {
      UploadProcessState ss = generateState(state);
      ss.image = event.image;

      yield ss;
      await ImageRecognitionProvider().imageRecognition(ss.image);
    } else if (event is UploadPost) {
      UploadProcessState ss = generateState(state);
      /*Post post = Post(
          title: ss.title,
          description: ss.description,
          imgUrl:
              "https://i.pinimg.com/originals/10/b2/f6/10b2f6d95195994fca386842dae53bb2.png");*/
      CoreLogic.instance.postLogic.add(AddPost(event.post));
      yield ss;
    }
  }

  UploadProcessState generateState(UploadProcessState state) {
    UploadProcessState ss = UploadProcessState.initial();
    ss.image = state.image;
    return ss;
  }
}
