import 'package:barter/event/AuthenticationEvent.dart';
import 'package:barter/provider/auth.dart';
import 'package:barter/provider/authentications.dart';
import 'package:barter/state/AuthenticationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationLogic
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationLogic() : super(AuthenticationState.initial());

  @override
  AuthenticationState get initialState => AuthenticationState.initial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is Login) {
      AuthenticationState ss = generateState(state);
      ss.isLoggedIn = true;
      yield ss;
    } else if (event is Signup) {
    } else if (event is Logout) {
      AuthenticationState ss = generateState(state);
      if (await signOutUser()) {
        ss.isLoggedIn = false;
      }

      yield ss;
    }
  }

  AuthenticationState generateState(AuthenticationState state) {
    AuthenticationState ss = AuthenticationState.initial();
    return ss;
  }
}
