import 'dart:ffi';

import 'package:maptravel/home/vo/vo_place.dart';
import 'package:maptravel/home/vo/vo_user.dart';

class Plane {
  final int id;
  final String subject;
  final String thumbnailUrl;
  final int viewCount;
  final int likeCount;
  final User user;
  final List<Place> placeList;

  Plane(this.id, this.subject, this.thumbnailUrl, this.viewCount,
      this.likeCount, this.user, this.placeList);
}