class Comment {
  final String text;
  final String userName;
  final String userId;
  final DateTime timestamp;

  Comment({
    required this.userName,
    required this.text,
    required this.userId,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'],
      userName: json['userName'],
      userId: json['user'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['text'] = text;
    data['user'] = userId;
    data['timestamp'] = timestamp;
    data['userName'] = userName;

    return data;
  }
}
