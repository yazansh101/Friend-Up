import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/acitivity_feed/screens/activity_screen.dart';
import 'package:movie_app/view/login/screens/login_screen.dart';
import 'package:movie_app/view/profile/screens/edite_profile_screen.dart';

import '../../view/chat/screens/chats_screen.dart';
import '../../view/home/screens/home.dart';
import '../../view/posts/screens/create_post_screen.dart';
import '../../view/splash/splash_screen.dart';

class Routes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String chats = '/chats';
  static const String profile = '/profile';
  static const String followers = '/followers';
  static const String notfication = '/notfication';
  static const String search = '/search';
  static const String createPost = '/createPost';
  static const String editeProfile = '/editeProfile';
  static const String userMessages = '/userMessages';
  static const String splashScreen = '/splashScreen';
  static const String login = '/loginScreen';


  static final Map<String, WidgetBuilder> routes = {
    home: (context) => StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context, authSnapshot) {
        if(authSnapshot.connectionState==ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        if (authSnapshot.hasData){
          return  const HomeScreen();
        }
        else{
        return const LoginScreen();
        }
      } ,
      ),
    auth: (context) => const LoginScreen(),
  chats: (context) => const ChatsScreen(),
  //  profile: (context) => const ProfileScreen(),
   notfication: (context) =>  const ActivityFeedScreen(),
   //followers: (context) =>  const FollowersScreen(),
   createPost: (context) =>   const CreatePostScreen(),
   editeProfile: (context) =>   const EditProfileScreen(),
   splashScreen: (context) =>  const MySplashScreen(),
   login: (context) =>  const LoginScreen(),


  };
}