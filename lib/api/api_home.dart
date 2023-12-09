import 'dart:convert';

import 'package:maptravel/common/secure_storage/secure_strage.dart';
import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:http/http.dart' as http;

import 'common.dart';

Future<PlaneListResponse> getPlaneList(int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final jsonResponse = await http.get(Uri.parse(
      '$baseUrl/v1/plane?size=5&page=$page'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

  Map<String, dynamic> parsedJson =
      json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}
