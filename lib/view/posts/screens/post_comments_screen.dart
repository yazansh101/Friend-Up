// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/view_models/activity_feed/activity_feed_view_model.dart';
import 'package:provider/provider.dart';

import '../../../view_models/activity_feed/activity_feed_service.dart';
import '../../../view_models/comments/comments_view_model.dart';
import '../../../view_models/user/user_view_model.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;

  const CommentsScreen({super.key, required this.postId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final CommentViewModel commentController = CommentViewModel();
  ActivityFeedService activityFeedController = ActivityFeedService();
  final _commentTextEditingController = TextEditingController();
  String _comment = '';
// builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const  Center(child: CircularProgressIndicator());
//                 }

String getMessageTime(Timestamp timestamp) {
  int timestampInMillis = timestamp.toDate().millisecondsSinceEpoch;
  Duration difference = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestampInMillis));
    
  if (difference.inDays > 365) {
    return 'more than year';
  }
  else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  }
   else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'mins'} ago';
  } else {
    return 'Just now';
  }
}

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamProvider<QuerySnapshot?>(
  create: (context) => commentController.getPostComments(widget.postId),
  initialData: null,
  child: Consumer<QuerySnapshot>(
    builder: (context, snapshot, _) {
      if (snapshot==null) {
        return
         const Center(child: Text('no comments'));
      //  const Center(child: LinearProgressIndicator());
      }
      final comments = snapshot.docs;
      return ListView.builder(
        reverse: true,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
            ),
            subtitle: Text(comment['text']),
            title: Text(comment['userName']),
           //  getMessageTime(comment['timestamp'].toMillis()
           //text: comment['timestamp'].toString(),
            trailing: CustomText(text: getMessageTime(comment['timestamp']),)
          );
        },
      );
    },
  ),
),
          ),
          const Divider(),
          ListTile(
            title: SizedBox(
              height: setHeight(6.5),
              child: TextFormField(
                onChanged: (value) {
                  _comment = value;
                },
                controller: _commentTextEditingController,
                decoration:  InputDecoration(
                
                  hintText: 'Add a comment...',
                  border:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                ),
                cursorHeight: 22,
              ),
            ),
            trailing: SizedBox(
              height: setHeight(6),
              child: ElevatedButton(
                
                onPressed: () {
                 
                  commentController.setComment(
                        postId: widget.postId,
                      text: _comment.toString(),
                      userId: userViewModel.currentUser.userId,
                      userName: userViewModel.currentUser.userName ,
                      );
                   Provider.of<ActivityFeedViewModel>(context,listen: false).setCommentActivityFeed(

                      postOwnerId: 'postOwnerId',
                      postId: widget.postId,
                      mediaUrl: 'mediaUrl',
                      userProfileImage: 'userProfileImage',
                      userName: 'userName');
                  _commentTextEditingController.clear();
                },
                child: const Text('Post'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
