// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/size_config.dart';
import '../../../core/helper/time_helper.dart';
import '../../../models/message_model.dart';
import '../../../view_models/chat/chat_view_model.dart';
import '../../../view_models/user/user_view_model.dart';
import '../../home/widgets/profile_picture_online.dart';
import '../../login/screens/login_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../widgets/messages.dart';
import '../widgets/send_message_bar.dart';

class ChatScreen extends StatelessWidget {
  final Map<String, dynamic> args;
  const ChatScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final chatId = args['chatId'];

    return Scaffold(
        appBar:
            _buildChatScreenBar(context, args['ownerId'], args['ownerName']),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildMessages(chatId),
            SendMessagesBar(
              ownerProfileImage:args['ownerProfileImage'],
              chatId: chatId,
              ownerId: args['ownerId'],
              userName: args['ownerName'],
            )
          ],
        ));
  }

  Consumer<ChatViewModel> _buildMessages(chatId) {
    return Consumer<ChatViewModel>(
      builder: (context, chatViewModel, child) => StreamBuilder(
          stream: chatViewModel.getNewMessage(chatId: chatId),
          builder: (context, messagesSnapshot) {
            if (messagesSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (messagesSnapshot.hasError) {
              return Center(
                  child: CustomText(text: '${messagesSnapshot.error}'));
            } else {
              List<Message>? messages = messagesSnapshot.data!.docs
                  .map((doc) => Message.fromJson(doc))
                  .toList();
              return Messages(messages: messages, chatId: chatId);
            }
          }),
    );
  }
}

AppBar _buildChatScreenBar(
    BuildContext context, String ownerId, String ownerName) {
  final userViewModel = Provider.of<UserViewModel>(context, listen: false);
  // final auth = Provider.of<AuthViewModel>(context);

  const roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  ));
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: getColorTheme(),
    elevation: 0.2,
    shadowColor: Colors.grey.shade500,
    shape: roundedRectangleBorder,
    leadingWidth: double.infinity,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileSection(context, ownerId, ownerName, userViewModel),
        _buildCallSection(context)
      ],
    ),
  );
}

Row _buildCallSection(BuildContext context) {
  return Row(
    children: [
      InkWell(
          onTap: () {},
          child: Image.asset(
            iconName('video-camera-alt'),
            scale: 22,
            color: getContentColorTheme(),
          )),
      setHorizentalSpace(7),
      InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Image.asset(
            iconName('phone-call'),
            scale: 23,
            color: getContentColorTheme(),
          )),
      setHorizentalSpace(5),
    ],
  );
}

Row _buildProfileSection(BuildContext context, String ownerId, String ownerName,
    UserViewModel userViewModel) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: getContentColorTheme(),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                        userId: ownerId,
                        userName: ownerName,
                        key: ValueKey(ownerId),
                      )));
        },
        child: ProfilePictuerOnline(
          imageUrl: userViewModel.currentUser.imageProfileUrl,
          ownerId: ownerId,
          radius1: 20,
          radius2: 12,
        ),
      ),
      setHorizentalSpace(3),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: ownerName,
            fontSize: 15,
          ),
          setVerticalSpace(0.2),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(ownerId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final lastSeen = snapshot.data!['status']['lastSeen'];
                  return CustomText(
                    text: TimeHelper.getLastSeen(lastSeen),
                    fontSize: 11,
                  );
                }
                return const CustomText(text: '');
              }),
        ],
      ),
    ],
  );
}
