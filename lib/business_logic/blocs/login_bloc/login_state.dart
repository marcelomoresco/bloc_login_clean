// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedState extends LoginState {
  final String email;

  LoginLoadedState(this.email);
}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);
}
