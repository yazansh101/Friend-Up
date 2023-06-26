import 'package:flutter/material.dart';

import '../../home/widgets/fill_out_line_button.dart';

class SelectBetween extends StatefulWidget {
  final int postsCount;
  final int videosCount;
  const SelectBetween({
    super.key,
    required this.postsCount,
    required this.videosCount,
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
              text: '${widget.postsCount} Posts ',
              onPressed: _changeMood,
              isPressed: isExploreMode ? true : false,
            ),
          ),
          Expanded(
            child: FillOutLineButton(
              text: '${widget.videosCount} Videos',
              onPressed: _changeMood,
              isPressed: isExploreMode ? false : true,
            ),
          )
        ],
      ),
    );
  }
}
