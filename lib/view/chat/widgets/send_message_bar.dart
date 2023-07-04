import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/view_models/chat/chat_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../view_models/chat/message_controller.dart';
import '../../../view_models/user/user_view_model.dart';

class SendMessagesBar extends StatefulWidget {
  final String ownerId;
  final String ownerProfileImage;
  final String userName;
  final String chatId;

  const SendMessagesBar({
    super.key,
    required this.ownerId,
    required this.userName,
    required this.chatId,
    required this.ownerProfileImage,
  });

  @override
  State<SendMessagesBar> createState() => _SendMessagesBarState();
}

class _SendMessagesBarState extends State<SendMessagesBar> {
  final messageController = MessageController();
  final TextEditingController _textFieldController = TextEditingController();

  String _message = '';
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context,listen:false);
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: getColorTheme(),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _textFieldController,
                    onChanged: (message) {
                      setState(() {
                        _message = message;
                      });
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(6),
                      hintText: 'Send a message ..',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
               
                setHorizentalSpace(1),
              
              ],
            ),
          ),
        ),
        InkWell(
          radius: 18,
          onTap: () async {
            chatProvider.sendMessage(null,
            friendProfileImage: widget.ownerProfileImage ,
                currentUserId: userProvider.currentUser.userId,
                friendName: widget.userName,
                friendId: widget.ownerId,
                chatId: widget.chatId,
                message: _message);
            _textFieldController.clear();
          },
          child: Container(
              height: 52,
              width: 52,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: getColorTheme(),
              ),
              child: Image.asset(
                iconName('send'),
                scale: 24,
                color: kPrimaryColor,
              )),
        ),
      ],
    );
  }
}
