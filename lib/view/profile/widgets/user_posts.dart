import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/navigator_service.dart';
import '../../../view_models/user/user_view_model.dart';
import '../../../view_models/user_posts/user_posts_view_model.dart';
import '../screens/post_details_screen.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final userPostViewModel =
        Provider.of<UserPostsViewModel>(context, listen: false);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return _buildPostsItems(
        userViewModel.currentUser.userId, userPostViewModel);
  }

  Expanded _buildPostsItems(userId, UserPostsViewModel postViewModel) {
    return Expanded(
      child: GridView.builder(
        key: ValueKey(userId),
        scrollDirection: Axis.vertical,
        itemCount: postViewModel.userPosts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1, crossAxisCount: 2),
        itemBuilder: (context, index) => _buildPostItem(index, context),
      ),
    );
  }

  GestureDetector _buildPostItem(int index, BuildContext context) {
    final postViewModel =
        Provider.of<UserPostsViewModel>(context, listen: false);
    final postId = postViewModel.userPosts[index].id;
    final post = postViewModel.userPosts[index];

    return GestureDetector(
      key: ValueKey(postId),
      onTap: () {
        NavigatorService.pushFadeTransition(
          context,
          PostDetailsScreen(post: post),
        );
      },
      child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.network(
            postViewModel.userPosts[index].mediaUrl,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey,
              child: Text('$error'),
            ),
          )),
    );
  }
}
