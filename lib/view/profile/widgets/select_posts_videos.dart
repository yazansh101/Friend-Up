import 'package:flutter/material.dart';

import '../../home/widgets/fill_out_line_button.dart';

class SelectBetween extends StatefulWidget {
  const SelectBetween({
    super.key,
  });

  @override
  State<SelectBetween> createState() => _SelectBetweenState();
}

class _SelectBetweenState extends State<SelectBetween> {
  bool isExploreMode = true;
  _changeMood() {
    setState(() {
      isExploreMode = !isExploreMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: FillOutLineButton(
              text: 'Posts',
              onPressed: _changeMood,
              isPressed: isExploreMode ? true : false,
            ),
          ),
          Expanded(
            child: FillOutLineButton(
              text: 'Videos',
              onPressed: _changeMood,
              isPressed: isExploreMode ? false : true,
            ),
          )
        ],
      ),
    );
  }
}