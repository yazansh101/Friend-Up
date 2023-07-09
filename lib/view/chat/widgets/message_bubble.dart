import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/custom_text.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,

    required this.messageContent,
    required this.time,
    this.isSent = true,
    this.isDelivered = false,
    required this.isLastMessage,
    required this.isMe,
  });


  final String messageContent;
  final String time;
  final bool isSent;
  final bool isDelivered;
  final bool isLastMessage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    // final backgroundColor = isSent ? Colors.blue : Colors.grey.shade200;
    // final iconColor = isSent ? Colors.white : Colors.black;
    final borderRadius = BorderRadius.only(
      bottomLeft: const Radius.circular(15),
      topLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
      bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
      topRight: const Radius.circular(15),
      
    );
      final backgroundColor = isMe
      ?  kPrimaryLightColor
      : kPrimaryColor;
      
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            stepWidth: 50,
            stepHeight: 20,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: CustomText(
                        text: messageContent,
                        color: isMe?textColor :Colors.white,
                        alignment: Alignment.centerLeft,
                        fontSize: 15,
                      ),
                    ),
                    setHorizentalSpace(0.5),
                  ],
                )),
          ),
          setVerticalSpace(1),
          if (isLastMessage)
            Row(
              children: [
                CustomText(
                  text: time,
                  color: Colors.grey.shade600,
                  alignment: Alignment.centerLeft,
                  fontSize: 12,
                ),
                setHorizentalSpace(1),
                if (isSent && isDelivered)
                  const Icon(Icons.done_all, size: 16, color: Colors.blue),
              ],
            ),
        ],
      ),
    );
  }
}
