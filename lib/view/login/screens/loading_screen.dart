import 'package:flutter/widgets.dart';
import 'package:movie_app/core/widgets/custom_text.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomText(text: 'loading ..',),);
  }
}