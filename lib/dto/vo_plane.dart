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
  final bool isLikes;
  final bool isBookmark;
  final List<Place> placeList;

  Plane({
    required this.id,
    required this.subject,
    required this.content,
    required this.country,
    required this.city,
    required this.viewCount,
    required this.thumbnailUrl,
    required this.userNickname,
    required this.userProfileImageUrl,
    required this.isLikes,
    required this.isBookmark,
    required this.placeList,
  });

  factory Plane.fromJson(Map<String, dynamic> json) {
    List<Place> placeList = (json['placeDtoList'] as List<dynamic>)
        .map((jsonPlace) => Place.fromJson(jsonPlace))
        .toList();

    return Plane(
      id: json['id'],
      subject: json['subject'],
      content: json['content'],
      country: json['country'],
      city: json['city'],
      viewCount: json['viewCount'],
      thumbnailUrl: json['thumbnailUrl'],
      userNickname: json['userNickname'],
      userProfileImageUrl: json['userProfileImageUrl'],
      isLikes: json['isLikes'],
      isBookmark: json['isBookmark'],
      placeList: placeList,
    );
  }
}
