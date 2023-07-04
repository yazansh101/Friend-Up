import 'package:flutter/material.dart';

class NavigatorService {
  static Future pushFadeTransition(
      BuildContext context, Widget destinationWidget,{Object? arguments}) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            destinationWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        settings: arguments != null ? RouteSettings(arguments: arguments) : null,
      ),
    );
  }


  static Future pushSlideTransition(
      BuildContext context, Widget destinationWidget) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        
        pageBuilder: (context, animation, secondaryAnimation) =>
            destinationWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation,),
            child: child,
          );
        },
      ),
    );
  }

  static Future pushNamedFadeTransition(
      BuildContext context, String routeName) {
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: FadeTransitionRoute(),
      
    );
  }
}

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget? page;
  final int durationMs;

  FadeTransitionRoute({
    this.page,
    this.durationMs = 250,
  }) : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              page!,
          transitionDuration: Duration(milliseconds: durationMs),
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
