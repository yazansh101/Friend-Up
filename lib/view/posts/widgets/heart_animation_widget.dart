import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  final Duration duration;
  final double size;
  final Color color;
  final Widget child;
  final bool isAnimating;

  const HeartAnimation({super.key, 
    required this.duration,
    required this.size,
    required this.color,
    required this.child,
     required this.isAnimating,
  });

  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeTween;
  late Animation<double> _opacityTween;
  late Animation<double> _curveTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _sizeTween = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );
    _opacityTween = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _curveTween = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );
   if(widget.isAnimating) _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.scale(
        scale: _sizeTween.value * widget.size,
        child: Opacity(
          opacity: _opacityTween.value,
          child: widget.child,
        ),
      ),
    );
  }
}
