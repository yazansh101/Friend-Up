// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/view/acitivity_feed/screens/activity_screen.dart';
import 'package:movie_app/view/chat/screens/chats_screen.dart';
import 'package:movie_app/view/posts/screens/posts_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/navigator_service.dart';
import '../../../core/helper/progress_indecator.dart';
import '../../../view_models/time_line/time_line_view_model.dart';
import '../../../view_models/user/user_view_model.dart';
import '../../profile/screens/profile_screen.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/bottom_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State with WidgetsBindingObserver {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initAppData();
    super.initState();
  }

  // void setStatues(String status) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(_authCredintail.currentUser!.uid)
  //       .update({'status': status});
  //   print(status);
  // }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     setStatues('Active now');
  //   } else {
  //     setStatues('offline');
  //   }
  // }

  initAppData() async {
    await Provider.of<UserViewModel>(context, listen: false)
        .initcurrentUserData();
    await Provider.of<TimeLinePostsViewModel>(context, listen: false)
        .initPosts();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap: closeKeyboard,
      child: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) => Scaffold(
          //appBar: _buildAppBar(_currentIndex, context),
          body: userViewModel.isFetchingUserData
              ? LoadingIndicator.buildLoadingIndicator()
              : _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  _onTap(int index) {
    setState(() {
      if (index - _currentIndex > 1 || _currentIndex - index > 1) {
        _currentIndex = index;
        _pageController.jumpToPage(index);
      } else {
        _currentIndex = index;
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  CustomBottomNavigationBar _buildBottomNavigationBar() {
    return CustomBottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
    );
  }

  PageView _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: const [
        PostsScreen(),
        SearchScreen(),
        ActivityFeedScreen(),
        ChatsScreen()
      ],
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  AppBar? _buildAppBar(index, context) {
    final userViewMOdel = Provider.of<UserViewModel>(context, listen: true);
    if (index == 0) {
      return AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              setHorizentalSpace(2),
              const Text(
                'Friend Up',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(left: 22),
                child: GestureDetector(
                  onTap: () {
                    NavigatorService.pushFadeTransition(
                      context,
                      ProfileScreen(
                        userId: userViewMOdel.currentUser.userId,
                        userName: userViewMOdel.currentUser.userName,
                        key: ValueKey(userViewMOdel.currentUser.userId),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      userViewMOdel.currentUser.imageProfileUrl,
                    ),
                    radius: 19,
                  ),
                ),
              )
            ],
          ),
        ),
        leadingWidth: double.infinity,
      );
    } else {
      return null;
    }
  }
}
