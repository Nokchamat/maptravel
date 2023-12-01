import 'dart:convert';

import 'package:maptravel/dto/vo_plane_list.dart';
import 'package:http/http.dart' as http;

final baseUrl =
    'http://ec2-13-209-203-81.ap-northeast-2.compute.amazonaws.com:8080';

Future<PlaneListResponse> getPlaneList() async {
  final jsonResponse = await http.get(Uri.parse('$baseUrl/v1/plane'));

  Map<String, dynamic> parsedJson =
      json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}
