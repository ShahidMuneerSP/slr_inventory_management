// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slr_inventory_management/Screens/Dashboard/controller/dashboardController.dart';
import 'package:slr_inventory_management/Screens/Dashboard/widgets/adCarousel.dart';
import 'package:slr_inventory_management/Screens/Dashboard/widgets/main_drawer.dart';
import 'package:slr_inventory_management/Screens/Purchase/view/purchase_view.dart';
import 'package:slr_inventory_management/Screens/Sales/view/sales_view.dart';

import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  Dashboardcontroller dashboardcontroller = Get.put(Dashboardcontroller());
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? name;
  String? userName;

  @override
  void initState() {
    getData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dashboardcontroller.scrollController;
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
    super.initState();
  }

  Future<void> getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name');
      userName = pref.getString('username');
    });
    await dashboardcontroller.fetchData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      key: scaffoldKey,
      backgroundColor: AppColors.bgColor,

      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.mainBg),
        ),
        child: CustomScrollView(
          controller: dashboardcontroller.scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            perfectSliverAppBar(),

            PerfectSliverSection(
              position: _slideAnimation,
              opacity: _fadeAnimation,
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar perfectSliverAppBar() {
    return SliverAppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ),
      ),

      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.appbarBlueGradient,
          ),
        ),
      ),

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome back, ",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),

      actions: [
        Container(
          margin: const EdgeInsets.only(right: 5, top: 12, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 23,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=8",
                ),
                onBackgroundImageError: (exception, stackTrace) {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],

      // AppBar Properties
      surfaceTintColor: AppColors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.mainBg,
      expandedHeight: 80,
      collapsedHeight: 80,
      toolbarHeight: 80,
    );
  }
}

class PerfectSliverSection extends StatelessWidget {
  final Widget? carouselWidget;
  final double? carouselHeight;
  final EdgeInsets? padding;
  final Animation<Offset> position;
  final Animation<double> opacity;

  const PerfectSliverSection({
    super.key,
    this.carouselWidget,
    this.carouselHeight,
    this.padding,
    required this.position,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;

    final backgroundHeight = screenWidth * 0.18;
    final carouselContainerHeight = carouselHeight ?? screenWidth * 0.41;
    final carouselWidth = screenWidth * 0.9;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: screenWidth,
          //   height: 10,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       colors: AppColors.appbarBlueGradient,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: screenWidth,
            height: carouselContainerHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: backgroundHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppColors.appbarBlueGradient,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                //SalesPerformanceCarousel(),
                // Carousel container with proper elevation
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: carouselWidth,
                      height: carouselContainerHeight * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AdCarousil(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FadeTransition(
              opacity: opacity,
              child: SlideTransition(
                position: position,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShadowContainer(
                      radius: 15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text(
                                "Actions",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildActionCard(
                                  context,
                                  "Sales",
                                  Icons.shopping_cart_rounded,
                                  () {
                                    Get.to(SalesView());
                                  },
                                ),
                                const SizedBox(width: 12),
                                _buildActionCard(
                                  context,
                                  "Purchase",
                                  Icons.receipt_long_rounded,
                                  () {
                                    Get.to(PurchaseView());
                                  },
                                ),
                                const SizedBox(width: 12),
                                _buildActionCard(
                                  context,
                                  "Inventory",
                                  Icons.inventory_rounded,
                                  () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: const Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard(
                          "Today's\nSales",
                          "₹0",
                          Icons.attach_money_rounded,
                          Colors.black, // Softer green
                          const Color(0xFFF0FDF4), // Very light green
                          size,
                        ),
                        _buildStatCard(
                          "Today's\nPurchases",
                          "₹0",
                          Icons.shopping_bag_rounded,
                          Colors.black, // Softer red
                          const Color(0xFFFEF2F2), // Very light red
                          size,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard(
                          "Low Stock\nItems",
                          "0",
                          Icons.warning_rounded,
                          Colors.black, // Warm orange
                          const Color(0xFFFFFBEB), // Very light amber
                          size,
                        ),
                        _buildStatCard(
                          "Total\nInventory",
                          "₹0",
                          Icons.inventory_rounded,
                          Colors.black, // Softer blue
                          const Color(0xFFEFF6FF), // Very light blue
                          size,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard(
                          "Total\nSales",
                          "₹0",
                          Icons.trending_up_rounded,
                          Colors.black, // Softer purple
                          const Color(0xFFF5F3FF), // Very light purple
                          size,
                        ),
                        _buildStatCard(
                          "Total\nPurchase",
                          "₹0",
                          Icons.trending_down_rounded,
                          Colors.black,
                          const Color(0xFFFDF2F8),
                          size,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color accentColor,
    Color backgroundColor,
    Size size,
  ) {
    return CustomShadowContainer(
      width: size.width / 2.3,
      radius: 16,

      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: accentColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,

    void Function()? onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),

          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.mainBg,
                  child: Icon(icon, size: 24, color: Colors.white),
                ),
                const SizedBox(height: 8),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Geist",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black,
                  ),

                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
