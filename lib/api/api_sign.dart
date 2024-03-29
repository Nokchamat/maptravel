import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/common/secure_storage/secure_strage.dart';

import '../sign/s_sign.dart';
import 'common.dart';

class Token {
  final String accessToken;
  final String refreshToken;

  Token(this.accessToken, this.refreshToken);
}

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

  return Token(
      response.headers['access_token']!, response.headers['refresh_token']!);
}

Future<Token?> refreshToken(BuildContext context) async {
  String? refreshToken;
  await getRefreshToken()
  .catchError((onError) {
    print(onError);
  })
  .then((value) => {
    print('=========value========='),
    print(value),
    print('=========value========='),
    refreshToken = value
  });

  final response =
      await http.get(Uri.parse('$baseUrl/v1/token/refresh'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "refresh_token": refreshToken!,
  });

  if (response.statusCode != 200) {
    print('=========200 아님=========');
    print(response.headers);
    print('=========200 아님=========');
    
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SignScreen()));
  } else {
    print('=========token=========');
    print(response.headers);
    print('=========token=========');

    return Token(response.headers['access_token']!, response.headers['refresh_token']!);
  }

  return null;
}
