import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final String senderId;
  final bool isRead;
  final Timestamp createdAt;

  Message({
    required this.content,
    required this.senderId,
    required this.isRead,
    required this.createdAt,
  });

  factory Message.fromJson(dynamic json) {
    return Message(
      content: json['content'],
      senderId: json['senderId'],
      isRead: json['isRead'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'senderId': senderId,
        'isRead': isRead,
        'createdAt': createdAt
      };
}
