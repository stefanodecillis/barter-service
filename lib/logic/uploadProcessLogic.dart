import 'package:barter/event/uploadProcessEvent.dart';
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
    }
  }

  UploadProcessState generateState(UploadProcessState state) {
    UploadProcessState ss = UploadProcessState.initial();
    return ss;
  }
}
