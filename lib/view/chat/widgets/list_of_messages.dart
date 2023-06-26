import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/size_config.dart';
import '../../../core/widgets/custom_text.dart';

ListView listOfMessages(
    BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
  return ListView.separated(
    itemCount: streamSnapShot.data!.docs.length,
    separatorBuilder: (context, index) => setVerticalSpace(5),
    itemBuilder: (context, index) => Row(
      children: [
        _buildListViewMessages(
            index, streamSnapShot.data!.docs, getTextColorTheme())
      ],
    ),
  );
}

Widget _buildListViewMessages(int index, List docs, Color textColor) {
  final color = index.isEven ? getPrimaryColorTheme() : kPrimaryyDarkColor;
  const borderRadius = BorderRadius.only(
    bottomLeft: Radius.circular(0),
    topLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
    topRight: Radius.circular(15),
  );
  return FittedBox(
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      height: 50,
      //width: 230, //change this as needed
      child: CustomText(
        text: docs[index]['content'],
        color: textColor,
        alignment: Alignment.centerLeft,
        fontSize: 15,
      ),
    ),
  );
}
