import 'package:flutter/material.dart';
import 'package:movie_app/core/helper/navigator_service.dart';
import 'package:movie_app/core/widgets/user_card.dart';
import 'package:movie_app/models/user_model.dart';
import 'package:movie_app/view/profile/screens/profile_screen.dart';
import 'package:movie_app/view_models/searching/searching_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/progress_indecator.dart';
import '../../../core/helper/lottie_animation.dart';
import '../../../core/constants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchViewMOdel = Provider.of<SearchViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _buildSearchField(searchViewMOdel),
            searchViewMOdel.isSearching
                ? Center(child: LoadingIndicator.buildLoadingIndicator())
                : _buildListOfSearchingResult(searchViewMOdel),
          ],
        ),
      ),
    );
  }

  Padding _buildSearchField(SearchViewModel searchViewMOdel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: true,
        style: const TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          hintText: 'Search...',
          filled: true,
          fillColor: Colors.white,
          suffixIcon: searchViewMOdel.isSearching
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    searchViewMOdel.closeSearching();
                  },
                )
              : null,
        ),
        controller: searchViewMOdel.controller,
        onSubmitted: (value) {
          if (value.isEmpty || value == '') {
            return;
          } else {
            searchViewMOdel.searchforUser(value);
          }
        },
      ),
    );
  }

  Widget _buildListOfSearchingResult(SearchViewModel searchViewMOdel) {
    return searchViewMOdel.usersOfSearchingReslut.isEmpty
        ? const LottieAnimation(
            asset: 'assets/lottie_files/empty-ghost.json',
            width: 200.0,
            height: 200.0,
            loop: true,
          )
        : Expanded(
            child: ListView.builder(
              itemCount: searchViewMOdel.usersOfSearchingReslut.length,
              itemBuilder: (BuildContext context, int index) {
                final user = searchViewMOdel.usersOfSearchingReslut[index];
                return _buildUserItem(context, user);
              },
            ),
          );
  }

  GestureDetector _buildUserItem(BuildContext context, User user) {
    return GestureDetector(
      onTap: () {
        NavigatorService.pushFadeTransition(context,
            ProfileScreen(userId: user.userId, userName: user.userName));
      },
      child: UserCard(
          name: user.userName,
          userImageUrl: user.imageProfileUrl,
          userId: user.userId),
    );
  }
}
