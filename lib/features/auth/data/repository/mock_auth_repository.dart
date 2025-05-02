import 'dart:developer';
import 'dart:ui';

import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  String get name => "Mock auth repository";

  @override
  Future<(String, String)> signIn(
      {required String email, required String password}) async {
    if (email == "1111@." && password == "1111") {
      await Future.delayed(const Duration(seconds: 2));
      log("Mock login completed successfully");
      return ("access_token", "refresh_token");
    } else {
      throw Exception("Uncorrect email or password");
    }
  }

  @override
  Future<(String, String)> signUp(
      {required String username,
      required String password,
      required String email,
      required VoidCallback onSend}) async {
    if (username != "1111" && email != "1111@.") {
      onSend.call();
      await Future.delayed(const Duration(seconds: 2));
      log("Mock registration completed successfully");
      return ("access_token", "refresh_token");
    } else {
      throw Exception("User has exited");
    }
  }
}
