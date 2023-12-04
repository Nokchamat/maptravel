import 'dart:convert';

import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:http/http.dart' as http;

import 'common.dart';

Future<PlaneListResponse> getPlaneList() async {
  final jsonResponse = await http.get(Uri.parse('$baseUrl/v1/plane'));

  Map<String, dynamic> parsedJson =
      json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}
