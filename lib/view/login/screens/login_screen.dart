// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_app/view/login/widgets/socal_buttons.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/size_config.dart';
import '../widgets/login_form.dart';
import '../widgets/sign_up_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isSign = false;
  late AnimationController _animationController;
  late Animation<double> _rotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _rotate =
        Tween<double>(begin: 0, end: -pi / 2).animate(_animationController);
  }

  void updateScreen() {
    setState(() {
      isSign = !isSign;
    });
    isSign ? _animationController.forward() : _animationController.reverse();
  }

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    super.initState();
    setUpAnimation();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final screenWidth = SizeConfig.screenWidth;
    final screenHeight = SizeConfig.screenHeight;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _rotate,
        builder: (context, child) => SingleChildScrollView(
          child: Stack(
            children: [
              AnimatedPositioned(
                right: null,
                duration: Duration(milliseconds: 400),
                child: InkWell(
                  onTap: isSign ? updateScreen : () {},
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    color: kPrimaryyDarkColor,
                    child: LoginForm(),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                width: screenWidth * 0.84,
                height: screenHeight,
                left: isSign ? screenWidth * 0.16 : screenWidth * 0.84,
                child: InkWell(
                  onTap: isSign ? () {} : updateScreen,
                  child: Container(
                    color: kPrimaryColor,
                    child: SignUpForm(),
                  ),
                ),
              ),
              setVerticalSpace(5),
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                left: isSign ? screenWidth * 0.1 : 0,
                right: isSign ? 0 : screenWidth * 0.12,
                bottom: screenWidth * 0.3,
                child: SocialButton(isSignIn: isSign),
              ),
              AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  left: isSign ? -screenWidth * 0.2 : screenWidth * 0.3,
                  right: isSign ? screenWidth * 0.84 - 84 : 145,
                  bottom: isSign ? screenHeight * 0.5 : screenWidth * 0.7,
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 300),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSign ? 23 : 32,
                      color: !isSign ? Colors.white38 : Colors.white,
                    ),
                    child: Transform.rotate(
                      //    alignment: Alignment.topRight,
                      angle: _rotate.value,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Log In ',
                        ),
                      ),
                    ),
                  )),
              AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  left: isSign ? screenWidth * 0.1 : screenWidth * 0.81,
                  right: isSign ? screenWidth * 0.01 : null,
                  bottom: isSign ? screenHeight * 0.3 : screenHeight * 0.5,
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 300),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isSign ? 32 : 23,
                      color: isSign ? Colors.white38 : Colors.white,
                    ),
                    child: Transform.rotate(
                      angle: _rotate.value + pi / 2,
                      child: Text(
                        'Sign Up  ',
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
