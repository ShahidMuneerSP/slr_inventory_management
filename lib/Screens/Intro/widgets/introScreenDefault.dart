// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:intro_slider/intro_slider.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
// import 'package:slr/view/user/mainuser/signup_or_login_page.dart';

// import '../../../utils/color.dart';

class IntroScreenDefault extends StatefulWidget {
  const IntroScreenDefault({super.key});

  @override
  IntroScreenDefaultState createState() => IntroScreenDefaultState();
}

class IntroScreenDefaultState extends State<IntroScreenDefault> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();
    listContentConfig.add(
      ContentConfig(
        styleDescription: TextStyle(color: Colors.black, fontSize: 15),
        styleTitle: TextStyle(
          color: AppColors.mainBg,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        heightImage: 100,
        title: "Shop Easy,Live Better",
        description:
            "Your gatway to effortless shopping and richer life,Explore world of convenience,quality and saving your fingertips",
        pathImage: 'assets/Images/gif1.webp',
        backgroundColor: Colors.white,
      ),
    );

    listContentConfig.add(
      ContentConfig(
        styleDescription: TextStyle(color: Colors.black, fontSize: 15),
        styleTitle: TextStyle(
          color: AppColors.mainBg,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        heightImage: 100,
        title: "Make Payment",
        description:
            "Easily settle your grocery bills and enjoy seemless checkout experience.Pay for fresh produce and everyday essential with confidence",
        pathImage: 'assets/images/animation_lmh8fb7m_small.gif',
        backgroundColor: Colors.white,
      ),
    );

    listContentConfig.add(
      ContentConfig(
        styleDescription: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        styleTitle: TextStyle(
          color: AppColors.mainBg,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        heightImage: 100,
        title: "Quality Products",
        description:
            "We curate the finest selection of fresh groceries and premium goods to ensure you receive nothing but the best. Elevate your shopping experience with top-tier products.",
        pathImage: 'assets/images/animation_lmh8rvs2_small.gif',
        backgroundColor: Colors.white,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      doneButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: Colors.black),
        ),
      ),
      skipButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: Colors.black),
        ),
      ),
      nextButtonStyle: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(color: Colors.black),
        ),
      ),
      key: UniqueKey(),
      // listCustomTabs: listContentConfig,
      listContentConfig: listContentConfig,
     // onDonePress: onDonePress,
    );
  }
}
