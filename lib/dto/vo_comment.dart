class Comment {
  final int id;
  final int planeId;
  final int userId;
  final String userNickname;
  final String comment;
  final String profileImageUrl;
  final bool isMine;
  final List<int> createdAt;

  Comment({
    required this.id,
    required this.planeId,
    required this.userId,
    required this.userNickname,
    required this.comment,
    required this.profileImageUrl,
    required this.createdAt,
    required this.isMine,
  });

  String getCreatedAtDateTime() {
    return "${createdAt[0]}.${createdAt[1]}.${createdAt[2]}";
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      planeId: json['planeId'],
      userId: json['userId'],
      userNickname: json['userNickname'],
      comment: json['comment'],
      profileImageUrl: json['userProfileImageUrl'],
      createdAt: List<int>.from(json['createdAt']),
      isMine: json['isMine'],
    );
  }
}


class CommentResponse {
  final List<Comment> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int size;
  final int number;
  final int numberOfElements;
  final bool first;
  final bool empty;

  CommentResponse({
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

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      content: (json['content'] as List)
          .map((commentJson) => Comment.fromJson(commentJson))
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
