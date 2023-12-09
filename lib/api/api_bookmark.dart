import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maptravel/api/common.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';

import '../dto/vo_bookmark.dart';

Future<BookmarkResponse> getBookmark(int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final response = await http
      .get(Uri.parse('$baseUrl/v1/plane/bookmark?size=8&page=$page'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });

  return BookmarkResponse.fromJson(
      json.decode(utf8.decode(response.bodyBytes)));
}

Future<http.Response> removeBookmark(int id) async {
  String? accessToken;
  accessToken = await getAccessToken();

  return await http
      .delete(Uri.parse('$baseUrl/v1/plane/$id/bookmark'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });
}
