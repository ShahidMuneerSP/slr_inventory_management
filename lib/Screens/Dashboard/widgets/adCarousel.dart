// ignore_for_file: must_be_immutable, file_names, deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

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

class SalesPerformanceCarousel extends StatelessWidget {
  // Dummy sales performance data
  final SalesPerformance dummyPerformance = SalesPerformance(
    totalSales: 12540.75,
    monthlyProgress: 0.75,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.commonDarkestBlue.withOpacity(0.9),

                    AppColors.commonDarkestBlue.withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _buildSalesPerformanceUI(dummyPerformance, context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSalesPerformanceUI(SalesPerformance performance, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text(
            'Sales Performance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),

          SizedBox(height: 7),

          // Total Sales Card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹${performance.totalSales.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8),

          // Progress indicators
          _buildProgressIndicator(
            'Monthly Target',
            performance.monthlyProgress,
            '₹${(performance.totalSales / performance.monthlyProgress).toStringAsFixed(0)}',
            context,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(
    String label,
    double progress,
    String target,
    context,
  ) {
    Color progressColor = progress >= 0.7
        ? Color(0xFF4ade80) // Modern green
        : progress >= 0.4
        ? Color(0xFFfbbf24) // Modern orange
        : Color(0xFFef4444); // Modern red

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                target,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),

        // Progress bar with animation-ready design
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Color(0xFF1e293b), // Dark slate background
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              children: [
                // Progress fill
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [progressColor, progressColor.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: progressColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '${(progress * 100).toStringAsFixed(0)}% Completed',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              '${((1 - progress) * 100).toStringAsFixed(0)}% remaining',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SalesPerformance {
  final double totalSales;
  final double monthlyProgress;

  SalesPerformance({required this.totalSales, required this.monthlyProgress});
}
