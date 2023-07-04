// ignore_for_file: public_member_api_docs, sort_constructors_first


class Post {
  String id;
  String discription;
  String ownerId;
  String mediaUrl;
  String ownerName;
  String ownerProfileImage;
  DateTime timestamp;
  Map<String,dynamic> likes;

  Post({
    required this.id,
    required this.discription,
    required this.ownerId,
    required this.ownerProfileImage,
    required this.mediaUrl,
    required this.ownerName,
    required this.timestamp,

    required this.likes,
  });

  factory Post.fromJson( dynamic json) {
    return Post(
      ownerName: json['ownerName'],
      id: json['id'],
      discription: json['discription'],
      ownerId: json['ownerId'],
      likes: json['likes'],
      mediaUrl: json['mediaUrl'],
      timestamp: json['timestamp'].toDate(), 
      ownerProfileImage:json['ownerProfileImage'],

    );
  }
  
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['id'] = id;
    data['discription'] = discription;
    data['ownerId'] = ownerId;
    data['likes'] = likes;
    data['mediaUrl'] = mediaUrl;
    data['timestamp'] = timestamp;
    data['ownerName'] = ownerName;
    data['ownerProfileImage'] = ownerProfileImage;


    return data;
  }

}