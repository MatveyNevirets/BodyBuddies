import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/auth/generated/bodybuddies_auth.pbgrpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';

class ProdAuthRepository implements AuthRepository {
  @override
  String get name => "Production auth repository";

  late final AuthRpcClient _client;

  ProdAuthRepository() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "127.0.0.1", port: 4001, transportSecure: false);
    _client = AuthRpcClient(channel);
  }

  @override
  Future<(String, String)> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<(String, String)> signUp(
      {required String username,
      required String password,
      required String email}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
