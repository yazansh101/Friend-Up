import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/view/home/widgets/profile_picture_online.dart';
import 'package:movie_app/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../services/firebase_auth/firebase_auth_service.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final int numOfMessagesNonRead;
  final String lastMessage;
  final String time;
  final String ownerId;
  final String ownerImageUrl;

  const ChatCard(
      {super.key,
      required this.name,
      required this.lastMessage,
      required this.numOfMessagesNonRead,
      required this.time,
      required this.ownerImageUrl,
      required this.ownerId});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService authCredintail = FirebaseAuthService();
    SizeConfig.init(context);
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: getColorTheme(),
    );

    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(defaultpadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfilePicture(),
          setHorizentalSpace(5),
          _buildUserNameSection(),
          const Spacer(),
          _buildLastMessageTime(authCredintail, context),
        ],
      ),
    );
  }

  ProfilePictuerOnline _buildProfilePicture() {
    return ProfilePictuerOnline(
            ownerId: ownerId,
            radius1: 19,
            radius2: 12,
            imageUrl: ownerImageUrl);
  }

  Column _buildLastMessageTime(FirebaseAuthService authCredintail, context) {
    final userViewMOdel = Provider.of<UserViewModel>(context, listen: false);
    return Column(
      children: [
        Opacity(opacity: 0.7, child: CustomText(text: time)),
        setVerticalSpace(1.3),
        StreamBuilder(
          stream: userViewMOdel.getUserStatus(userViewMOdel.currentUser.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!['status']['isOnline']) {
                return Container(
                  height: 22,
                  width: 22,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: CustomText(
                      text: numOfMessagesNonRead.toString(),
                      color: SizeConfig.mediaQueryData.platformBrightness ==
                              Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  Column _buildUserNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: name,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        setVerticalSpace(0.5),
        CustomText(text: lastMessage),
      ],
    );
  }
}
