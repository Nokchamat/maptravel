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

Future<http.StreamedResponse> updateNickname(nickname) async {
  String? accessToken;
  accessToken = await getAccessToken();

  var formData =
      http.MultipartRequest('PUT', Uri.parse('$baseUrl/v1/user/nickname'));
  formData.fields.addAll({'nickname': nickname});
  formData.headers['access_token'] = accessToken!;

  return await formData.send();
}

Future<http.StreamedResponse> updateProfile(profileImage) async {
  String? accessToken;
  accessToken = await getAccessToken();

  var formData =
      http.MultipartRequest('PUT', Uri.parse('$baseUrl/v1/user/profileimage'));
  formData.files.add(
      await http.MultipartFile.fromPath('profileImage', profileImage!.path));

  formData.headers['access_token'] = accessToken!;

  return await formData.send();
}

Future<http.Response> reSendEmail() async {
  String? accessToken;
  accessToken = await getAccessToken();

  return await http.get(Uri.parse('$baseUrl/v1/user/resend-email'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });
}

Future<http.Response> verifyEmail(code) async {
  String? accessToken;
  accessToken = await getAccessToken();

  return await http.post(
    Uri.parse('$baseUrl/v1/user/verify?code=$code'),
    headers: {
      "access_token": accessToken ?? "",
    },
  );
}
