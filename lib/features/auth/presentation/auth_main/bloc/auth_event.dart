part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  String email, password;
  AuthEvent(this.email, this.password);

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  String username;

  SignUpEvent(super.email, super.password, this.username);
}

class SignInEvent extends AuthEvent {
  SignInEvent(super.email, super.password);
}
