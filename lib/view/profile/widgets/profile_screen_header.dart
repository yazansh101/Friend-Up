
 

  import 'package:flutter/material.dart';

import '../../../core/widgets/custom_text.dart';

Row profileScreenHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10.0),
          child: const CircleAvatar(
            child: Icon(
              Icons.arrow_back,
              size: 18,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10.0),
          child: const CircleAvatar(
            child: CustomText(
              text: '...',
              color: Colors.white,
              fontSize: 25,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }

