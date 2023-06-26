class Chat {
  String userId;
  String name;
  String image;
  String lastMessage;
  DateTime lastMessageTime;
  int unreadMessages;

  Chat({
    required this.userId,
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadMessages,
  });

  Chat.fromJson(dynamic json)
      : userId = json['userId'],
        name = json['name'],
        image = json['image'],
        lastMessage = json['lastMessage'],
        lastMessageTime = DateTime.parse(json['lastMessageTime']),
        unreadMessages = json['unreadMessages'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'image': image,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime.toIso8601String(),
        'unreadMessages': unreadMessages,
      };
}
