// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Intro/controller/introController.dart';
import 'package:slr_inventory_management/Screens/Intro/widgets/terms_widget.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class IntroSplash extends StatelessWidget {
  IntroSplash({super.key});

  final control = Get.put(Introcontroller());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(flex: 1),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: SizedBox(
                  width: height / 3,
                  child: Image.asset('assets/Images/slr_logo.png'),
                ),
              ),
            ),
            Spacer(flex: 1),
            // SizedBox(
            //   height: 125,
            // ),
            Container(
              height: height < 750
                  ? height / 1.6
                  : height > 1200
                  ? height / 3.0
                  : height / 2.0,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 1),
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(flex: 1),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      "One Platform \nEndless Opportunity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Inspired by you",

                        //yatraOne,satisfy
                        style: TextStyle(
                          fontFamily: "Geist",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  // sizedh20,
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Image.asset(
                      'assets/Images/shopping-bag.webp',
                      height: 60,
                    ),
                  ),
                  // sizedh30,
                  Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 10,
                    ),
                    child: MaterialButton(
                      color: AppColors.mainBg,
                      height: 50,
                      minWidth: width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      onPressed: () {
                        control.skip.value = true;
                        termsandCondition(context);
                      },
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // sizedh20,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 10,
                    ),
                    child: MaterialButton(
                      color: AppColors.mainBg,
                      height: 50,
                      minWidth: width,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        control.skip.value = false;
                        termsandCondition(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SignUp()),
                        // );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  termsandCondition(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return TermsWidget();
      },
    );
  }
}
