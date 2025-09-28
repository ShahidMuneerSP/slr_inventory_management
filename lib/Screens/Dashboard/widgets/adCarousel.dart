// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdCarousil extends StatelessWidget {
  var images = [
    'assets/Images/pic1.webp',
    'assets/Images/pic2.webp',
    'assets/Images/pic3.webp',
    'assets/Images/pic4.webp',
    'assets/Images/pic5.webp',
  ];

  AdCarousil({super.key});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          height: MediaQuery.of(context).size.width / 3.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width / 3.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 1,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
      ),
    );
  }
}
