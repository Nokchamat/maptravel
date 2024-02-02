import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maptravel/api/common.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_comment.dart';

Future<CommentResponse> getComment(int planeId, int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final response = await http.get(
      Uri.parse('$baseUrl/v1/plane/${planeId}/comment?size=20&page=$page'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

  return CommentResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
}

Future<http.Response> createComment(int planeId, String comment) async {
  String? accessToken;
  accessToken = await getAccessToken();

  return await http.post(
      Uri.parse('$baseUrl/v1/plane/${planeId}/comment?comment=$comment'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });
}

Future<http.Response> removeComment(int id) async {
  String? accessToken;
  accessToken = await getAccessToken();

  return await http
      .delete(Uri.parse('$baseUrl/v1/comment/$id'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });
}
