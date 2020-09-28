import 'package:barter/event/IntersectionEvent.dart';
import 'package:barter/respository/intersectionRepository.dart';
import 'package:barter/state/IntersectionState.dart';
import 'package:barter/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntersectionLogic extends Bloc<IntersectionEvent, IntersectionState> {
  IntersectionLogic() : super(IntersectionState.initial());

  @override
  IntersectionState get initialState => IntersectionState.initial();

  IntersectionRepository _repository = new IntersectionRepository();

  @override
  Stream<IntersectionState> mapEventToState(IntersectionEvent event) async* {
    if (event is FetchIntersections) {
      IntersectionState ss = generateState(state);
      ss.intersections = await _repository.getIntersections();
      yield ss;
    } else if (event is FetchFilter) {
      IntersectionState ss = generateState(state);
      if (event.pattern == '')
        yield ss;
      else {
        ss.filtered = true;
        ss.filteredIntersections = filterList(ss.intersections, event.pattern);
        yield ss;
      }
    } else if (event is RestoreResult) {
      IntersectionState ss = generateState(state);
      ss.filtered = false;
      ss.filteredIntersections = [];
      yield ss;
    }
  }

  IntersectionState generateState(IntersectionState state) {
    IntersectionState ss = IntersectionState.initial();
    ss.intersections = state.intersections;
    ss.filtering = state.filtering;
    ss.filtered = state.filtered;
    ss.filteredIntersections = state.filteredIntersections;
    return ss;
  }
}
