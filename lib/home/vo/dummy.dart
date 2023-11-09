import 'dart:ffi';

import 'package:maptravel/home/vo/vo_place.dart';
import 'package:maptravel/home/vo/vo_plane.dart';
import 'package:maptravel/home/vo/vo_user.dart';

List<Place> placeList = [
  Place(
      "도쿄 여행", "도쿄에서 여행하는 것을 계획했어요!", "imageUrl", 33.5, 22.5)
];

User user = User(
    1,
    "https://ios-note-bucket.s3.ap-northeast-2.amazonaws.com/profile/DefaultProfile.png",
    "녹차");

List<Plane> planeList = [
  Plane(
      1,
      "신나는 도쿄 여행",
      "https://images.unsplash.com/photo-1454391304352-2bf4678b1a7a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D",
      221,
      351,
      user,
      placeList),
  Plane(
      2,
      "3일 동안 빡쌘 여행",
      "https://images.unsplash.com/photo-1568323993144-20d546ba585d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      335,
      161,
      user,
      placeList),
  Plane(
      3,
      "여러가지 온천 다니기",
      "https://images.unsplash.com/photo-1554357475-accb8a88a330?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      6617,
      194198,
      user,
      placeList),
];
