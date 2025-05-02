import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/auth/domain/tokens.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SecureStorage storage;

  AuthBloc(this.authRepository, this.storage) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<AuthInitEvent>(_initAuth);
  }

  FutureOr<void> _initAuth(event, emit) async {
    emit(AuthLoadingState());
    try {
      final data = await storage.read(AppConsts.tokenKey);
      final tokens = Tokens.fromJson(data);
      if (tokens.accessToken.isEmpty) throw Exception("You're not authorized");
      emit(UserHasAuthtorized());
    } on Object catch (e, st) {
      emit(UserNotAuthtorized());
      onError(e, st);
    }
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final response = await authRepository.signUp(
        username: event.username,
        password: event.password,
        email: event.email,
      );

      final tokens =
          Tokens(accessToken: response.$1, refreshToken: response.$2);
      await storage.write(AppConsts.tokenKey, tokens.toJson());
      emit(UserHasAuthtorized());
    } catch (e) {
      emit(ErrorState(
          "Ошибка регистрации, возможно такой аккаунт уже существует. Попробуйте снова"));
      emit(UserNotAuthtorized());
    }
  }

  void _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final response = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      final tokens =
          Tokens(accessToken: response.$1, refreshToken: response.$2);
      await storage.write(AppConsts.tokenKey, tokens.toJson());
      emit(UserHasAuthtorized());
    } catch (e) {
      emit(ErrorState("Неверный логин или пароль"));
      emit(UserNotAuthtorized());
    }
  }
}
