import 'dart:ffi';

import 'package:maptravel/dto/vo_place.dart';

class Plane {
  final int id;
  final String subject;
  final String content;
  final String country;
  final String city;
  final int viewCount;
  final String thumbnailUrl;
  final String userNickname;
  final String userProfileImageUrl;
  final Bool isLikes;
  final Bool isBookmark;
  final List<Place> placeDtoList;

  Plane(
    this.id,
    this.subject,
    this.content,
    this.country,
    this.city,
    this.viewCount,
    this.thumbnailUrl,
    this.userNickname,
    this.userProfileImageUrl,
    this.isLikes,
    this.isBookmark,
    this.placeDtoList,
  );
}
