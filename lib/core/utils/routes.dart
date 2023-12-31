import 'package:flutter/material.dart';
import 'package:movie_app/view/acitivity_feed/screens/activity_screen.dart';
import 'package:movie_app/view/home/screens/home.dart';
import 'package:movie_app/view/login/screens/login_screen.dart';
import 'package:movie_app/view/profile/screens/edite_profile_screen.dart';

import '../../view/chat/screens/chats_screen.dart';
import '../../view/posts/screens/create_post_screen.dart';
import '../../view/splash/splash_screen.dart';

class Routes {
  static const String home = '/home';
  static const String auth = '/auth';
  static const String chats = '/chats';
  static const String notfication = '/notfication';
  static const String createPost = '/createPost';
  static const String editeProfile = '/editeProfile';
  static const String splashScreen = '/splashScreen';
  static const String login = '/loginScreen';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    auth: (context) => const LoginScreen(),
    chats: (context) => const ChatsScreen(),
    notfication: (context) => const ActivityFeedScreen(),
    createPost: (context) => const CreatePostScreen(),
    editeProfile: (context) => const EditProfileScreen(),
    splashScreen: (context) => const MySplashScreen(),
    login: (context) => const LoginScreen(),
  };
}
