
// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/fontStyle/font.dart';

class PurchaseLoadingWidget extends StatelessWidget {
  String? loading;
  PurchaseLoadingWidget({
    this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return loading == null
          ? Center(
              child: SizedBox(
                height: 25,
                child: LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,
                    colors: 
                      
                        AppColors.darkBlueGradient),
              ),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(loading!, style: CustomTextStyle.heading1),
              Center(
                child: SizedBox(
                  height: 25,
                  child: LoadingIndicator(
                      indicatorType: Indicator.lineSpinFadeLoader,
                      colors:AppColors.darkBlueGradient),
                ),
              )
            ]);
    
  }
}