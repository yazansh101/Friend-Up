
import 'package:flutter/material.dart';

import '../../../core/constants/size_config.dart';
import '../../../core/widgets/custom_text.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.infoTitle,
    required this.info,
  });

  final String infoTitle;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: info,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        setVerticalSpace(1),
        CustomText(
          text: infoTitle,
          fontSize: 12,
          color: Colors.white,
        ),
      ],
    );
  }
}
