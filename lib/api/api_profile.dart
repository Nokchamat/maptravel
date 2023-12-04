import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maptravel/common/secure_storage/secure_strage.dart';

import '../dto/vo_user.dart';
import 'common.dart';

Future<User> getProfile(BuildContext context) async {
  String? accessToken;

  final jsonResponse =
      await http.get(Uri.parse('$baseUrl/v1/user/myprofile'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });

  Map<String, dynamic> parsedJson =
      json.decode(utf8.decode(jsonResponse.bodyBytes));

  return User.fromJson(parsedJson);
}
