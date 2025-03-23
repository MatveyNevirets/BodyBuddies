abstract interface class AuthRepository {
  String get name;

  Future<(String,String)> signIn({required String email, required String password});

  Future<(String,String)> signUp(
      {required String username,
      required String password,
      required String email});
}
