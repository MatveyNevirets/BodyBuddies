import 'dart:convert';

class Tokens {
  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory Tokens.fromMap(Map<String, dynamic> map) {
    return Tokens(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tokens.fromJson(String source) =>
      Tokens.fromMap(json.decode(source) as Map<String, dynamic>);

  Tokens({required this.accessToken, required this.refreshToken});
}
