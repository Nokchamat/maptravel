import 'dart:convert';

import 'package:http/http.dart' as http;

class Token {
  final String accessToken;
  final String refreshToken;

  Token(this.accessToken, this.refreshToken);
}

const String baseUrl =
    'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080';

Future<Token> signIn(email, password) async {
  var response = await http.post(
    Uri.parse('$baseUrl/v1/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  return Token(response.headers['access_token']!, response.headers['refresh_token']!);
}
