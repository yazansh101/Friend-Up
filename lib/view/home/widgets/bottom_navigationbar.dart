// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/core/helper/navigator_service.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/routes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final screenHeight = SizeConfig.screenHeight;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildBottons(screenHeight),
        _buildCreatePostIcon(context),
      ],
    );
  }

  Container _buildBottons(double screenHeight) {
    return Container(
        height: screenHeight * .09,
        decoration: BoxDecoration(
            color: getColorTheme(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.70),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child:Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      InkWell(
        radius: 25,
        onTap: () => onTap(0),
        child: Image.asset(
          AppIcons.home,
          color: currentIndex == 0 ? kPrimaryColor : Colors.grey.shade300,
          scale: currentIndex == 0 ? 23 : 25,
        ),
      ),
      InkWell(
        radius: 25,
        onTap: () => onTap(1),
        child: Image.asset(
          AppIcons.search,
          color: currentIndex == 1 ? kPrimaryColor : Colors.grey.shade300,
          scale: currentIndex == 1 ? 23 : 25,
        ),
      ),
      InkWell(
        radius: 25,
        onTap: () => onTap(2),
        child: Image.asset(
          AppIcons.bell,
          color: currentIndex == 2 ? kPrimaryColor : Colors.grey.shade300,
          scale: currentIndex == 2 ? 23 : 25,
        ),
      ),
      InkWell(
        radius: 25,
        onTap: () => onTap(3),
        child: Image.asset(
          AppIcons.comment,
          color: currentIndex == 3 ? kPrimaryColor : Colors.grey.shade300,
          scale: currentIndex == 3 ? 23 : 25,
        ),
      ),
    ],
  ),
      );
  }

  Positioned _buildCreatePostIcon(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        top: -28,
        child: GestureDetector(
          onTap: () {
            NavigatorService.pushNamedFadeTransition(
                context, Routes.createPost);
          },
          child: const CircleAvatar(
            radius: 32,
            backgroundColor: kPrimaryColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
              shadows: [],
            ),
          ),
        ));
  }
}
