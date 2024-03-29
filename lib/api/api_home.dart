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

Future<PlaneListResponse> getPlaneListByLocation(String location, int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final jsonResponse = await http.get(Uri.parse(
      '$baseUrl/v1/plane/location?size=5&page=$page&country=$location&city=$location'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

  Map<String, dynamic> parsedJson =
  json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}

Future<PlaneListResponse> getPlaneListByNickname(String nickname, int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final jsonResponse = await http.get(Uri.parse(
      '$baseUrl/v1/plane/nickname?size=5&page=$page&nickname=$nickname'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

  Map<String, dynamic> parsedJson =
  json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}

Future<PlaneListResponse> getMyPlaneList(int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final jsonResponse = await http.get(Uri.parse(
      '$baseUrl/v1/plane/myplane?size=8&page=$page'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

  Map<String, dynamic> parsedJson =
  json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}

Future<PlaneListResponse> getPlaneListByUserId(int userId, int page) async {
  String? accessToken;
  accessToken = await getAccessToken();

  final jsonResponse = await http.get(Uri.parse(
      '$baseUrl/v1/plane/user/$userId?size=8&page=$page'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });

  Map<String, dynamic> parsedJson =
  json.decode(utf8.decode(jsonResponse.bodyBytes));

  return PlaneListResponse.fromJson(parsedJson);
}

Future<http.Response> removePlane(int planeId) async {
  String? accessToken;
  accessToken = await getAccessToken();

  return await http.delete(Uri.parse(
      '$baseUrl/v1/plane/$planeId'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "access_token": accessToken ?? "",
      });
}