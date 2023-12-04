import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maptravel/api/common.dart';
import 'package:maptravel/common/secure_storage/secure_strage.dart';

import '../dto/vo_bookmark.dart';

Future<BookmarkResponse> getBookmark() async {
  String? accessToken;
  accessToken = await getAccessToken();

  final response =
      await http.get(Uri.parse('$baseUrl/v1/plane/bookmark'), headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "access_token": accessToken ?? "",
  });

  Map<String, dynamic> parsedResponse =
      json.decode(utf8.decode(response.bodyBytes));

  return BookmarkResponse.fromJson(parsedResponse);
}
