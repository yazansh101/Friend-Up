import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/core/helper/shared_preferences.dart';
import 'package:movie_app/core/utils/theme.dart';
import 'package:movie_app/view_models/activity_feed/activity_feed_view_model.dart';
import 'package:movie_app/view_models/chat/chat_provider.dart';
import 'package:movie_app/view_models/chat/chat_view_model.dart';
import 'package:movie_app/view_models/followers/followers_controller.dart';
import 'package:movie_app/view_models/followers/followers_view_model.dart';
import 'package:movie_app/view_models/searching/searching_view_model.dart';
import 'package:movie_app/view_models/time_line/time_line_view_model.dart';
import 'package:movie_app/view_models/user/user_provider.dart';
import 'package:movie_app/view_models/user/user_view_model.dart';
import 'package:movie_app/view_models/user_posts/uesr_posts_provider.dart';
import 'package:movie_app/view_models/user_posts/user_posts_view_model.dart';
import 'package:provider/provider.dart';

import 'core/constants/constants.dart';
import 'core/helper/firebase_options.dart';
import 'core/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
                SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:kPrimaryColor,
    ),
  );

   return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserViewModel(UserProvider()),
        ),
        ChangeNotifierProvider.value(
          value: UserPostsViewModel(PostProvider(), PostCache()),
        ),
        ChangeNotifierProvider.value(
          value: FollowersViewModel(FollowersProvider()),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatViewModel(ChatProvider()),
          lazy: false,
        ),
        ChangeNotifierProvider.value(
          value: TimeLinePostsViewModel(PostProvider()),
        ),
        ChangeNotifierProvider.value(
          value: SearchViewModel(UserProvider()),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityFeedViewModel(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightThemeData(),
        darkTheme: darkThemeData(),
        themeMode: ThemeMode.system,
        initialRoute: Routes.splashScreen,
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
