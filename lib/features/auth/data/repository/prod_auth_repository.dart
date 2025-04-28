import 'package:body_buddies/features/auth/domain/repository/auth_repository.dart';
import 'package:body_buddies/features/auth/generated/bodybuddies_auth.pbgrpc.dart';
import 'package:body_buddies/internal/application/app_consts.dart';
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
      required String email}) async {
    final request = await _client.signUp(UserDto(
      email: email,
      password: password,
      username: username,
    ));

    return (request.accessToken, request.refreshToken);
  }
}
