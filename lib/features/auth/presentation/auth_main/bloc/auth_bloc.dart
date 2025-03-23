import 'package:bloc/bloc.dart';
import 'package:body_buddies/core/widgets/base_snackbar.dart';
import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(UserNotAuthtorized()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final response = await authRepository.signUp(
        username: event.username,
        password: event.password,
        email: event.email,
      );

      emit(UserHasAuthtorized(response.$1, response.$2));
    } catch (e) {
      emit(ErrorState("Пользователь с такой почтой или именем уже существует"));
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

      emit(UserHasAuthtorized(response.$1, response.$2));
    } catch (e) {
      emit(ErrorState("Неверный логин или пароль"));
      emit(UserNotAuthtorized());
    }
  }
}
