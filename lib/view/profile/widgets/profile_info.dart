// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'info_Item.dart';

class ProfileInfo extends StatelessWidget {

  String postsCount;
  String followersCount;
  String followingCount;

  ProfileInfo({
    Key? key,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black),
      color: Colors.grey,
    );
   
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 35),
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InfoItem(
            info: postsCount,
            infoTitle: 'Posts',
          ),
          InfoItem(
            info: followersCount,
            infoTitle: 'Followers',
          ),
          InfoItem(
            info: followingCount,
            infoTitle: 'Following',
          ),
        ],
      ),
    );
  }
}
