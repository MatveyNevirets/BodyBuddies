import 'dart:async';
import 'dart:ui';

import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/auth/generated/bodybuddies_auth.pbgrpc.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdAuthRepository implements AuthRepository {
  @override
  String get name => "Production auth repository";

  late final AuthRpcClient _client;

  ProdAuthRepository() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: AppConsts.hostAddress,
        port: AppConsts.nginxPort,
        transportSecure: false);
    _client = AuthRpcClient(channel);
  }

  @override
  Future<(String, String)> signIn(
      {required String email, required String password}) async {
    final response =
        await _client.signIn(UserDto(email: email, password: password));
    return (response.accessToken, response.refreshToken);
  }

  @override
  Future<(String, String)> signUp(
      {required String username,
      required String password,
      required String email,
      required VoidCallback onSend}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    try {
      await userCredential.user?.sendEmailVerification();

      onSend.call();

      await waitForEmailVerification(userCredential.user);

      final request = await _client.signUp(UserDto(
        email: email,
        password: password,
        username: username,
      ));

      return (request.accessToken, request.refreshToken);
    } on Object catch (error, stack) {
      throw Exception("Error: $error, Stack: $stack");
    } finally {
      await userCredential.user!.delete();
    }
  }

  Future<void> waitForEmailVerification(User? user) async {
    if (user == null) return;

    FirebaseAuth auth = FirebaseAuth.instance;

    while (!user!.emailVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await user.reload();
      user = auth.currentUser;
    }
  }
}
