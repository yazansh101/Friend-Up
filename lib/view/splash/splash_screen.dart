import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/constants/constants.dart';
import 'main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addStatusListener(
        (status) {
        //  if (mounted) {
            if (status == AnimationStatus.completed) {
              Navigator.of(context).pushReplacement(
                PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: const MainScreen(),
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 800)),
              );
             
              resetController(const Duration(milliseconds: 800));
            }
         // }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(seconds: 2), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  Future<void> resetController(Duration duration) async {
    await Future.delayed(duration);
    if (mounted) {
      scaleController.reset();
    }
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('SplashScreen');
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 30.0),
          child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Friend Up',
                speed: const Duration(milliseconds: 150),
              ),
            ],
            isRepeatingAnimation: false,
            repeatForever: false,
            displayFullTextOnTap: false,
          ),
        ),
      ),
    );
  }
}
