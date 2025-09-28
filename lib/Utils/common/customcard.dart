// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class CustomShadowContainer extends StatelessWidget {
  double? width;
  double? height;
  Widget child;
  double radius;
  CustomShadowContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.radius = 7,
  });

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> shadow = [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.137),
        blurRadius: 15,
        spreadRadius: -3,
        offset: Offset(0, 10),
      ),
      BoxShadow(
        color: AppColors.commonBGColor,
        blurRadius: 6,
        spreadRadius: -2,
        offset: Offset(0, 4),
      ),
    ];
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: AppColors.white,
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}
