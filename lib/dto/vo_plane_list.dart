class PlaneList {
  final int planeId;
  final String subject;
  final String content;
  final String country;
  final String city;
  final String thumbnailUrl;
  final int viewCount;
  final int userId;
  final String userNickname;
  final String userProfileImageUrl;
  final bool isLikes;
  final bool isBookmark;
  final int likesCount;
  final int commentCount;

  PlaneList({
    required this.planeId,
    required this.subject,
    required this.content,
    required this.country,
    required this.city,
    required this.viewCount,
    required this.thumbnailUrl,
    required this.userId,
    required this.userNickname,
    required this.userProfileImageUrl,
    required this.isLikes,
    required this.isBookmark,
    required this.likesCount,
    required this.commentCount,
  });

  factory PlaneList.fromJson(Map<String, dynamic> json) {
    return PlaneList(
      planeId: json['planeId'],
      subject: json['subject'],
      content: json['content'],
      country: json['country'],
      city: json['city'],
      viewCount: json['viewCount'],
      thumbnailUrl: json['thumbnailUrl'].toString().replaceAll('https', 'http'),
      userId: json['userId'],
      userNickname: json['userNickname'],
      userProfileImageUrl:
          json['userProfileImageUrl'].toString().replaceAll('https', 'http'),
      isLikes: json['isLikes'],
      isBookmark: json['isBookmark'],
      likesCount: json['likesCount'],
      commentCount: json['commentCount'],
    );
  }
}

class PlaneListResponse {
  final List<PlaneList> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int size;
  final int number;
  final int numberOfElements;
  final bool first;
  final bool empty;

  PlaneListResponse({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory PlaneListResponse.fromJson(Map<String, dynamic> json) {
    return PlaneListResponse(
      content: (json['content'] as List)
          .map((planeJson) => PlaneList.fromJson(planeJson))
          .toList(),
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      numberOfElements: json['numberOfElements'],
      first: json['first'],
      empty: json['empty'],
    );
  }
}
