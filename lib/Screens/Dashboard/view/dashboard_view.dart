import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Dashboard/controller/dashboardController.dart';
import 'package:slr_inventory_management/Screens/Dashboard/widgets/adCarousel.dart';
import 'package:slr_inventory_management/Screens/Sales/view/sales_view.dart';

import 'package:slr_inventory_management/Utils/colors/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  Dashboardcontroller dashboardcontroller = Get.put(Dashboardcontroller());
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.mainBg),
        ),
        child: CustomScrollView(
          controller: dashboardcontroller.scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            PerfectSliverAppBar(),
            PerfectSliverSection(
              position: _slideAnimation,
              opacity: _fadeAnimation,
            ),
          ],
        ),
      ),
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
    final carouselContainerHeight = carouselHeight ?? screenWidth * 0.32;
    final carouselWidth = screenWidth * 0.9;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth,
            height: 10,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColors.appbarBlueGradient,
              ),
            ),
          ),

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
          SizedBox(height: 25),
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
             
                    const Text(
                      "Actions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildActionCard(
                          context,
                          "Sales",
                          Icons.shopping_cart_rounded,
                          const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                          ),
                          () {
                            Get.to(SalesView());
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildActionCard(
                          context,
                          "Inventory",
                          Icons.inventory_rounded,
                          const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)],
                          ),
                          () {},
                        ),
                        const SizedBox(width: 12),
                        _buildActionCard(
                          context,
                          "Purchase",
                          Icons.receipt_long_rounded,
                          const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                          ),
                          () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    const Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard(
                          "Today's\nSales",
                          "₹1,200",
                          Icons.attach_money_rounded,
                          const Color(0xFF059669), // Softer green
                          const Color(0xFFF0FDF4), // Very light green
                          size,
                        ),
                        _buildStatCard(
                          "Today's\nPurchases",
                          "₹1,200",
                          Icons.shopping_bag_rounded,
                          const Color(0xFFDC2626), // Softer red
                          const Color(0xFFFEF2F2), // Very light red
                          size,
                        ),
                        _buildStatCard(
                          "Low Stock\nItems",
                          "5",
                          Icons.warning_rounded,
                          const Color(0xFFEA580C), // Warm orange
                          const Color(0xFFFFFBEB), // Very light amber
                          size,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCard(
                          "Total\nInventory",
                          "₹25,000",
                          Icons.inventory_rounded,
                          const Color(0xFF2563EB), // Softer blue
                          const Color(0xFFEFF6FF), // Very light blue
                          size,
                        ),
                        _buildStatCard(
                          "Total\nSales",
                          "₹25,000",
                          Icons.trending_up_rounded,
                          const Color(0xFF7C3AED), // Softer purple
                          const Color(0xFFF5F3FF), // Very light purple
                          size,
                        ),
                        _buildStatCard(
                          "Total\nPurchase",
                          "₹25,000",
                          Icons.trending_down_rounded,
                          const Color(0xFFDB2777), // Softer pink
                          const Color(0xFFFDF2F8), // Very light pink
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
    return Container(
      width: size.width / 3.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
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
    Gradient gradient,
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

                // Category Name
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Geist",
                    fontWeight: FontWeight.w600,
                    fontSize: 14, // slightly smaller for 3-grid
                    color: Colors.black,
                  ),
                  maxLines: 3,
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

class PerfectSliverAppBar extends StatelessWidget {
  final String userName;
  final String storeName;
  final String avatarUrl;
  final String logoAsset;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoTap;

  const PerfectSliverAppBar({
    super.key,
    this.userName = "Shahid",
    this.storeName = "Shahid Store",
    this.avatarUrl = "https://i.pravatar.cc/150?img=8",
    this.logoAsset = 'assets/Images/slr_logo.png',
    this.onProfileTap,
    this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // Leading - Profile Avatar
      leading: Container(
        margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
        child: GestureDetector(
          onTap: onProfileTap,
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
              radius: 30,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(avatarUrl),
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
      ),

      // Flexible Space - Gradient Background
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
            "Welcome back, $userName",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            storeName,
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
          margin: const EdgeInsets.only(right: 16, top: 12, bottom: 12),
          child: GestureDetector(
            onTap: onLogoTap,
            child: Container(
              width: 56,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    logoAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.store,
                        color: AppColors.appbarBlueGradient.first,
                        size: 24,
                      );
                    },
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





// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:slr_inventory_management/Screens/Sales/view/sales_view.dart';
// import 'package:slr_inventory_management/Utils/colors/colors.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );

//     _slideAnimation =
//         Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
//           CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//         );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color(0xFFF8FAFC),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Welcome back, Shahid",
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//                 color: Color.fromARGB(255, 131, 163, 208),
//               ),
//             ),
//             const SizedBox(height: 2),
//             const Text(
//               "Shahid Store",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Image.asset(
//             'assets/Images/slr_logo.png',
//             height: MediaQuery.of(context).size.height / 8,
//             width: MediaQuery.of(context).size.height / 10,
//           ),
//           SizedBox(width: 10),
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: const CircleAvatar(
//               radius: 20,
//               backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
//             ),
//           ),
//         ],
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SlideTransition(
//           position: _slideAnimation,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [AppColors.primaryColor, AppColors.primaryColor],
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.primaryColor.withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: const Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Welcome back!",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Manage your inventory",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Icon(
//                         Icons.dashboard_rounded,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 const Text(
//                   "Quick Actions",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF1E293B),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Quick Actions Row
//                 Row(
//                   children: [
//                     _buildActionCard(
//                       context,
//                       "Sales",
//                       Icons.shopping_cart_rounded,
//                       const LinearGradient(
//                         colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
//                       ),
//                       () {
//                         Get.to(SalesView());
//                       },
//                     ),
//                     const SizedBox(width: 12),
//                     _buildActionCard(
//                       context,
//                       "Inventory",
//                       Icons.inventory_rounded,
//                       const LinearGradient(
//                         colors: [Color(0xFF10B981), Color(0xFF059669)],
//                       ),
//                       () {},
//                     ),
//                     const SizedBox(width: 12),
//                     _buildActionCard(
//                       context,
//                       "Purchase",
//                       Icons.receipt_long_rounded,
//                       const LinearGradient(
//                         colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
//                       ),
//                       () {},
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 32),

//                 const Text(
//                   "Overview",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF1E293B),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Summary Stats
//                 Expanded(
//                   child: GridView.count(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 0.79,
//                     children: [
//                       _buildStatCard(
//                         "Today's\n Sales",
//                         "₹1,200",
//                         Icons.attach_money_rounded,
//                         const Color(0xFF10B981),
//                         const Color(0xFFECFDF5),
//                       ),
//                       _buildStatCard(
//                         "Today's Purchases",
//                         "₹1,200",
//                         Icons.pending_actions_rounded,
//                         const Color(0xFFF59E0B),
//                         const Color(0xFFFEF3C7),
//                       ),
//                       _buildStatCard(
//                         "Low Stock Items",
//                         "5",
//                         Icons.warning_rounded,
//                         const Color(0xFFEF4444),
//                         const Color(0xFFFEF2F2),
//                       ),
//                       _buildStatCard(
//                         "Total\nInventory",
//                         "₹25,000",
//                         Icons.trending_up_rounded,
//                         const Color(0xFF3B82F6),
//                         const Color(0xFFEFF6FF),
//                       ),
//                       _buildStatCard(
//                         "Total\nSales",
//                         "₹25,000",
//                         Icons.trending_up_rounded,
//                         const Color(0xFF8B5CF6),
//                         const Color(0xFFF3F4F6),
//                       ),
//                       _buildStatCard(
//                         "Total\nPurchase",
//                         "₹25,000",
//                         Icons.trending_down_rounded,
//                         const Color(0xFFEC4899),
//                         const Color(0xFFFDF2F8),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActionCard(
//     BuildContext context,
//     String title,
//     IconData icon,
//     Gradient gradient,
//     void Function()? onTap,
//   ) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: gradient.colors.first.withOpacity(0.3),
//                 blurRadius: 12,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(icon, size: 28, color: Colors.white),
//                   const SizedBox(height: 8),
//                   Text(
//                     title,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(
//     String title,
//     String value,
//     IconData icon,
//     Color accentColor,
//     Color backgroundColor,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(
//                     6,
//                   ), // Slightly smaller icon container
//                   decoration: BoxDecoration(
//                     color: backgroundColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     icon,
//                     size: 20,
//                     color: accentColor,
//                   ), // Smaller icon
//                 ),
//                 const Spacer(),
//                 Container(
//                   width: 5,
//                   height: 5,
//                   decoration: BoxDecoration(
//                     color: accentColor,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ],
//             ),
//             // Reduced spacing
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF64748B),
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: accentColor,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget _buildStatCard(
//   //   String title,
//   //   String value,
//   //   IconData icon,
//   //   Color accentColor,
//   //   Color backgroundColor,
//   // ) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(20),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.black.withOpacity(0.05),
//   //           blurRadius: 15,
//   //           offset: const Offset(0, 5),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(20),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Row(
//   //             children: [
//   //               Container(
//   //                 padding: const EdgeInsets.all(8),
//   //                 decoration: BoxDecoration(
//   //                   color: backgroundColor,
//   //                   borderRadius: BorderRadius.circular(12),
//   //                 ),
//   //                 child: Icon(icon, size: 24, color: accentColor),
//   //               ),
//   //               const Spacer(),
//   //               Container(
//   //                 width: 6,
//   //                 height: 6,
//   //                 decoration: BoxDecoration(
//   //                   color: accentColor,
//   //                   shape: BoxShape.circle,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           const SizedBox(height: 16),
//   //           Text(
//   //             title,
//   //             style: const TextStyle(
//   //               fontSize: 14,
//   //               fontWeight: FontWeight.w500,
//   //               color: Color(0xFF64748B),
//   //             ),
//   //           ),
//   //           const SizedBox(height: 4),
//   //           Text(
//   //             value,
//   //             style: TextStyle(
//   //               fontSize: 24,
//   //               fontWeight: FontWeight.w700,
//   //               color: accentColor,
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
// ignore_for_file: deprecated_member_use