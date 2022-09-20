import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginSubmitted) {
        if (event.email.isEmpty || event.password.isEmpty) {
          emit(LoginErrorState("Campo Obrigatório"));
        } else {
          emit(LoginLoadingState());
          await Future.delayed(Duration(seconds: 3), () {
            emit(LoginLoadedState(event.email));
          });
        }
      }
    });
  }
}
