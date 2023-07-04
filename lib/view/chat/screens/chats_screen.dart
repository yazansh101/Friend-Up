import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_app/core/helper/navigator_service.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/view/chat/screens/chat_screen.dart';
import 'package:movie_app/view/home/widgets/chat_card.dart';
import 'package:movie_app/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/size_config.dart';
import '../../../core/helper/progress_indecator.dart';
import '../../../core/helper/time_helper.dart';
import '../../../models/message_model.dart';
import '../../../view_models/chat/chat_provider.dart';
import '../../../view_models/chat/chat_view_model.dart';
import '../../home/widgets/fill_out_line_button.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({
    super.key,
  });

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool isSign = false;
  bool isRecentMessages = true;
  bool isOnlyActive = false;
  final usersProvider = ChatProvider();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 1.0),
            child: CustomText(
              text: 'Messages',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              setVerticalSpace(3),
              listOfUsers(userViewModel.currentUser.userId.trim()),
            ],
          ),
        ),
      ),
    );
  }

  Widget listOfUsers(String userId) {
    return StreamBuilder(
        stream: usersProvider.getNewChat(userId),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator.buildLoadingIndicator();
          } else if (!userSnapshot.hasData) {
            return const Center(child: Text('there is no chats'));
          } else {
            return _buildItems(userSnapshot);
          }
        });
  }

  Expanded _buildItems(AsyncSnapshot<QuerySnapshot<Object?>> userSnapshot) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (context, index) => setVerticalSpace(1.5),
          itemCount:
              userSnapshot.data == null ? 1 : userSnapshot.data!.docs.length,
          itemBuilder: (context, index) {
            ChatViewModel chatViewModel =
                Provider.of<ChatViewModel>(context, listen: false);
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                    child: MaterialButton(
                  elevation: 4,
                  onPressed: () {
                    UserViewModel userViewModel =
                        Provider.of<UserViewModel>(context, listen: false);
                    final arguments = {
                      'chatId': userSnapshot.data!.docs[index]['chatId'],
                      'currentUserId': userViewModel.currentUser.userId,
                      'ownerName': userSnapshot.data!.docs[index]['userName'],
                      'ownerId': userSnapshot.data!.docs[index].id,
                      'ownerProfileImage': userSnapshot.data!.docs[index]
                              ['ownerProfileImage'] ??
                          ''
                    };
                    NavigatorService.pushFadeTransition(
                      context,
                      ChatScreen(args: arguments),
                    );
                  },
                  child: StreamBuilder(
                      stream: chatViewModel.getNewMessage(
                          chatId: userSnapshot.data!.docs[index]['chatId']),
                      builder: (context, messageSnapshot) {
                        if (messageSnapshot.hasData) {
                          List<Message>? messages = messageSnapshot.data!.docs
                              .map((doc) => Message.fromJson(doc))
                              .toList();
                          final listOfNonreadMessages = [];
                          messages.map((message) {
                            if (message.isRead == false) {
                              return listOfNonreadMessages.add(message);
                            }
                          }).toList();
                          int numOfMessagesNonRead =
                              listOfNonreadMessages.length;
                          return ChatCard(
                            ownerImageUrl: userSnapshot.data!.docs[index]
                                ['ownerProfileImage'],
                            numOfMessagesNonRead: numOfMessagesNonRead,
                            ownerId: userSnapshot.data!.docs[index].id,
                            lastMessage: messageSnapshot.data!.docs.isEmpty
                                ? ''
                                : messageSnapshot.data!.docs[0]['content'],
                            name: userSnapshot.data!.docs[index]['userName'],
                            time: TimeHelper.formatTime(
                                messageSnapshot.data!.docs[0]['createdAt']),
                          );
                        } else {
                          return Container();
                        }
                      }),
                )),
              ),
            );
          }),
    );
  }

  Widget headline() {
    return Stack(
      children: [
        Container(
          height: 75,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: getPrimaryColorTheme(),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 15),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Chats',
                color: Colors.white,
              ),
              Row(
                children: [
                  setHorizentalSpace(4),
                  FillOutLineButton(
                    isPressed: isRecentMessages,
                    onPressed: () {
                      setState(() {
                        isRecentMessages = !isRecentMessages;
                      });
                    },
                    text: 'Recent Chat',
                  ),
                  setHorizentalSpace(4),
                  FillOutLineButton(
                    isPressed: isOnlyActive,
                    onPressed: () {
                      setState(() {
                        isOnlyActive = !isOnlyActive;
                      });
                    },
                    text: 'Active',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
