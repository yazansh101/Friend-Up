import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';

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
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(width: 1, color: getColorTheme())),
      child:
           Image.network(mediaUrl!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    
                  )),
    );
  }
}
