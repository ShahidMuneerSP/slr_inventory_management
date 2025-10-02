// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class RoundContainer extends StatelessWidget {
  Color color;
  double width;
  double height;
  RoundContainer(
      {super.key,
      required this.color,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
