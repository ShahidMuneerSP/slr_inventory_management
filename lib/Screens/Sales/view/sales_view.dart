import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/view/customers_view.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Checking/view/sales_checking_view.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/view/sales_customer_view.dart';
import 'package:slr_inventory_management/Screens/Sales/View%20Held%20Bills/view/view_held_bills.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: AppColors.appbarBlueGradient),
              ),
            ),
            backgroundColor: AppColors.commonDarkestBlue,

            title: Text(
              "Sales",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.white,
              ),
            ),
            leading: InkWell(
              onTap: () => Get.back(),
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: AppColors.white, size: 20),
              ),
            ),

            elevation: 0,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildStatCard(
                        "Today's Sales",
                        "₹1,12,450",
                        Icons.trending_up_rounded,
                      ),
                      SizedBox(width: 12),
                      _buildStatCard(
                        "Pending Bills",
                        "12",
                        Icons.pending_actions_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Sales Features Grid
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildListDelegate([
                _buildFeatureCard(
                  title: "Customer Sales",
                  subtitle: "Process new sales",
                  icon: Icons.shopping_basket_rounded,
                  color: Color(0xFF4f6bff),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4f6bff), Color(0xFF3a56e6)],
                  ),
                  onTap: () => Get.to(SalesCustomerPage()),
                ),
                _buildFeatureCard(
                  title: "Customers",
                  subtitle: "Manage customers",
                  icon: Icons.people_rounded,
                  color: Color(0xFF00c9a7),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF00c9a7), Color(0xFF00b894)],
                  ),
                  onTap: () => Get.to(CustomersView()),
                ),
                _buildFeatureCard(
                  title: "Held Bills",
                  subtitle: "View pending bills",
                  icon: Icons.receipt_long_rounded,
                  color: Color(0xFFff9f43),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFff9f43), Color(0xFFf39c12)],
                  ),
                  onTap: () => Get.to(ViewHeldBills()),
                ),
                _buildFeatureCard(
                  title: "Sales Checking",
                  subtitle: "Review sales data",
                  icon: Icons.analytics_rounded,
                  color: Color(0xFFe66767),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFe66767), Color(0xFFe74c3c)],
                  ),
                  onTap: () => Get.to(SalesCheckScreen()),
                ),
              ]),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.mainBg.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: AppColors.mainBg, size: 24),
                  ),
                  SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
Widget _buildStatCard(String title, String value, IconData icon) {
  return Expanded(
    child: Card(
      elevation: 0, // Remove shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[300]!, // Add border
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
  // Widget _buildStatCard(String title, String value, IconData icon) {
  //   return Expanded(
  //     child: Card(
  //       elevation: 2,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       child: Padding(
  //         padding: EdgeInsets.all(15),
  //         child: Column(
  //           children: [
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 13,
  //                 color: Colors.grey[600],
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             Text(
  //               value,
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.black87,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
