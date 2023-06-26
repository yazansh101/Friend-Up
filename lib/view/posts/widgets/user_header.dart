import 'package:flutter/material.dart';

import '../../../core/constants/size_config.dart';
import '../../home/widgets/profile_picture_online.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final String postTime;
  final String postOwnerId;
  final String imageUrl;
  const UserHeader(
      {super.key,
      required this.userName,
      required this.postTime,
      required this.imageUrl,
      required this.postOwnerId});

  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePictuerOnline(
          imageUrl:imageUrl ,
          ownerId: postOwnerId,
          radius1: 18,
          radius2: 10,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName,
                style: const TextStyle(
                    fontFamily: 'Muli', fontWeight: FontWeight.bold)),
            setVerticalSpace(0.3),
            Text(postTime,
                style: const TextStyle(
                    fontFamily: 'Jet', color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
