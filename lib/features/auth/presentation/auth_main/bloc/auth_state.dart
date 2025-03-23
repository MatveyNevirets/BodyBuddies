part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class UserNotAuthtorized extends AuthState {}

class UserHasAuthtorized extends AuthState {
  String accessToken;
  String refreshToken;

  UserHasAuthtorized(this.accessToken, this.refreshToken);
}

class ErrorState extends AuthState {
  String message;

  ErrorState(this.message);
}
