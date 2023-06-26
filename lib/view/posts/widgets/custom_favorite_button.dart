import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFavoriteButton extends StatefulWidget {
  CustomFavoriteButton({
    super.key,
    this.iconColor ,
    this.backgroundColor,
    this.size = 25,
    this.onTap,
    required this.isFavorite,
  });

  Color? iconColor;
  Color? backgroundColor;
  double? size;
  bool isFavorite;
  void Function()? onTap;

  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {
  @override
  Widget build(BuildContext context) {
    print('build f');
    //   final postViewModel = Provider.of<PostViewModel>(context);
    //isFavorite=postViewModel.;

    return GestureDetector(
      onTap: () {
        widget.isFavorite = !widget.isFavorite;
        widget.onTap!();
      },
      child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: widget.isFavorite == true
              ? Icon(
                 FontAwesomeIcons.solidHeart,

                  color: widget.iconColor,
                  size: widget.size,
                )
              : Icon(
                   FontAwesomeIcons.heart,

                  color: widget.iconColor,
                  size: widget.size,
                )),
    );
  }
}
