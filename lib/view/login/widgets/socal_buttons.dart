import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/core/widgets/custom_text.dart';
import 'package:movie_app/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/routes.dart';
import '../../../view_models/user/user_view_model.dart';

class SocialButton extends StatelessWidget {
  final AuthViewModel _auth = AuthViewModel();
  bool isSignIn = false;
  SocialButton({Key? key, required this.isSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        User currentFireBaseUser = await _auth.signInWithGoogle();
        await userViewModel.createUserInfo(
            currentFireBaseUser.email!, currentFireBaseUser.displayName!);
         Navigator.pushReplacementNamed(context, Routes.home);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'Try with ',
            color: isSignIn ? Colors.white : Colors.white24,
          ),
          setVerticalSpace(2),
          Icon(
            FontAwesomeIcons.google,
            color: isSignIn ? Colors.white : Colors.white24,
          ),
        ],
      ),
    );
  }
}
