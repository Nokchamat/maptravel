class Place {
  final int id;
  final String subject;
  final String content;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> pictureUrlArray;

  Place({
    required this.id,
    required this.subject,
    required this.content,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.pictureUrlArray,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      subject: json['subject'],
      content: json['content'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      pictureUrlArray: (json['pictureUrlArray']
              as List<dynamic>)
          .map((url) => url.toString().replaceAll('https', 'http'))
          .toList(),
    );
  }
}
