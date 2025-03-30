part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  String username;
  String email, password;

  SignUpEvent(
      {required this.email, required this.password, required this.username});
}

class SignInEvent extends AuthEvent {
  String email, password;
  SignInEvent({required this.email, required this.password});
}

class AuthInitEvent extends AuthEvent {}
