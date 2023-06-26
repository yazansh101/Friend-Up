
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_text.dart';

class FillOutLineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPressed;
  final double? height;

  const FillOutLineButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isPressed, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height:height??45 ,
      elevation: isPressed?4:0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: onPressed,
      color: isPressed ? Colors.white : Colors.grey,
      child: CustomText(
        text: text,
        color: isPressed ? Colors.grey : Colors.white,
        fontSize: 15,
        fontWeight: isPressed ? FontWeight.w500 : FontWeight.w300,
      ),
    );
  }
}
