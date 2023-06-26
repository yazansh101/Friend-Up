import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/constants.dart';

class LoadingIndicator {
  static Widget buildLoadingIndicator(
      {double size = 25,
      Color color = kPrimaryColor,
      String type = 'Wave'}) {
    return Center(
      child: SpinKitWave(
        size: size,
        color: color,
      ),
    );
  }
}