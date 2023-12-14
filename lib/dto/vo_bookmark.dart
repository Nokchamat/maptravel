class Bookmark {
  final int id;
  final int planeId;
  final String subject;
  final String content;
  final String country;
  final String city;
  final String thumbnailUrl;

  Bookmark({
    required this.id,
    required this.planeId,
    required this.subject,
    required this.content,
    required this.country,
    required this.city,
    required this.thumbnailUrl,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      planeId: json['planeId'],
      subject: json['subject'],
      content: json['content'],
      country: json['country'],
      city: json['city'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class BookmarkResponse {
  final List<Bookmark> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int size;
  final int number;
  final int numberOfElements;
  final bool first;
  final bool empty;

  BookmarkResponse({
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

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkResponse(
      content: (json['content'] as List)
          .map((planeJson) => Bookmark.fromJson(planeJson))
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



