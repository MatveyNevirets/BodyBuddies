part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  String email, password;
  AuthEvent({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  String username;

  SignUpEvent(
      {required super.email, required super.password, required this.username});
}

class SignInEvent extends AuthEvent {
  SignInEvent({required super.email, required super.password});
}
