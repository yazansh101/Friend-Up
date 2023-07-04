import 'package:flutter/material.dart';

import '../../../core/constants/size_config.dart';
import '../../../core/widgets/custom_text.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.userName,
    required this.activityType,
    required this.time,
    required this.userId,
    required this.userImage,
  });

  final String userName;
  final String userId;
  final String userImage;
  final String activityType;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildProfilePicture(userImage),
      title: _buildActivityInfo(),
    );
  }

  Column _buildActivityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: '$userName $activityType ',
            fontSize: 16,
            alignment: Alignment.centerLeft),
        setVerticalSpace(0.5),
        CustomText(
          text: time,
          color: Colors.grey,
        ),
      ],
    );
  }

  CircleAvatar _buildProfilePicture(userImage) {
    return CircleAvatar(
      backgroundImage: NetworkImage(userImage),
      radius: 19,
    );
  }
}
