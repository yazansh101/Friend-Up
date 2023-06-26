class User {
  String userId;
  String userName;
  String email;
  String imageProfileUrl;
  String bio;
  DateTime joinedAt;
  Map<String, dynamic> status;

  User({
    required this.userId,
    required this.userName,
    required this.email,
    required this.imageProfileUrl,
    required this.bio,
    required this.joinedAt,
    required this.status,
  });

  factory User.fromJson(dynamic json) {
    return User(
        userId: json['userId'],
        userName: json['userName'],
        email: json['email'],
        imageProfileUrl: json['imageUrl'],
        bio: json['bio'],
        joinedAt: json['joinedAt'].toDate(),
        status: {
          'isOnline': json['status']['isOnline'],
          'lastSeen': json['status']['lastSeen'].toDate(),
        });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['userName'] = userName;
    data['email'] = email;
    data['imageUrl'] = imageProfileUrl;
    data['joinedAt'] = joinedAt;
    data['status'] = status;
    data['bio'] = bio;
    return data;
  }
}
