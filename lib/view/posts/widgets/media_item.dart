import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:movie_app/core/widgets/custom_text.dart';

class MediaItem extends StatelessWidget {
  final String? mediaUrl;
  const MediaItem({
   required this.mediaUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: setHeight(25),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            width: 1,
            color: getColorTheme()
          )),
          child: mediaUrl=="" ?
          Container(
            color: Colors.grey,
          ):Image.network(mediaUrl!,fit: BoxFit.fill,errorBuilder: (context, error, stackTrace) => CustomText(text: error.toString()),),
    );
  }
}
