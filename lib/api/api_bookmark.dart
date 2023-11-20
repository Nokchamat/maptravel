import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maptravel/common/secure_storage/secure_strage.dart';

import '../dto/vo_bookmark.dart';

const String baseUrl =
    'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080';

Future<BookmarkResponse> getBookmark() async {
  String? accessToken;
  accessToken = await getAccessToken();

  final jsonResponse =
      await http.get(Uri.parse('$baseUrl/v1/plane/bookmark'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });

  Map<String, dynamic> parsedJson =
      json.decode(utf8.decode(jsonResponse.bodyBytes));

  return BookmarkResponse.fromJson(parsedJson);
}
