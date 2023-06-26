import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final String asset;
  final double width;
  final double height;
  final bool loop;

 const LottieAnimation(
      {super.key, required this.asset,
      required this.width,
      required this.height,
      required this.loop});

  @override
  _LottieAnimationState createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
      child: Lottie.asset(
        widget.asset,
        width: widget.width,
        height: widget.height,
        repeat: widget.loop ? true : false,
        animate: _isPlaying,
      ),
    );
  }
}
