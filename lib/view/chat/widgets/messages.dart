// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/view/chat/widgets/message_bubble.dart';
import 'package:movie_app/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../models/message_model.dart';
import '../../../services/firebase_auth/firebase_auth_service.dart';
import '../../../view_models/chat/message_controller.dart';

class Messages extends StatelessWidget {
  final String chatId;
  final List<Message> messages;
  Messages({
    super.key,
    required this.chatId,
    required this.messages,
  }){
    log(messages.length.toString());
  }

  final messageController = MessageController();
  final FirebaseAuthService _authCredintail = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    //  final messages = Provider.of<List<Message>>(context);

    return Expanded(
      child: ListView.separated(
        reverse: true,
        scrollDirection: Axis.vertical,
        itemCount: messages.length,
        separatorBuilder: (context, index) => setVerticalSpace(1),
        itemBuilder: (context, index){
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child:     Row(
          mainAxisAlignment:
              messages[index].senderId == _authCredintail.currentUser!.uid
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            _buildMessageBubble(
              context,
              index,
              messages,
              getTextColorTheme(),
            )
          ],
        )
              ),
            ),
          );
          
      
        } 
      ),
    );
  }
}

Widget _buildMessageBubble(
  context,
  int index,
  List<Message> messages,
  Color textColor,
) {
  log('messages');
  final userViewModel=Provider.of<UserViewModel>(context);
final isMe= messages[index].senderId ==userViewModel.currentUser.userId;
  final color = isMe
      ? getPrimaryColorTheme()
      : kPrimaryLightColor;
  final borderRadius = BorderRadius.only(
    bottomLeft: const Radius.circular(15),
    topLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
    bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
    topRight: const Radius.circular(15),
  );
  final messageContent = messages[index].content;
  log(messages[index].content);
  return MessageBubble(
    time: "10:12 PM",
    backgroundColor: color,
    borderRadius: borderRadius,
    messageContent: messageContent,
    isLastMessage: index == 0,
  );
}
