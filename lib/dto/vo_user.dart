class User {
  final int id;
  final String nickname;
  final String profileImageUrl;
  final int followerCount;
  final bool isEmailVerify;

  User({
    required this.id,
    required this.nickname,
    required this.profileImageUrl,
    required this.followerCount,
    required this.isEmailVerify,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      profileImageUrl: json['profileImageUrl'],
      followerCount: json['followerCount'],
      isEmailVerify: json['isEmailVerify'],
    );
  }
}
