// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class CustomerSaleDetailedView extends StatelessWidget {
  const CustomerSaleDetailedView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> products = [
      {
        'productName': 'Marvel PLUS',
        'productId': 'PRD-001',
        'image': "assets/Images/download.jpeg",
        'qty': 1,
        'unit': 'L',
        'mrp': 2,
        'price': 1,
        'netAmount': 1,
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.appbarBlueGradient),
          ),
        ),
        backgroundColor: AppColors.commonDarkestBlue,

        iconTheme: IconThemeData(color: AppColors.white),
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
        title: Text(
          'INV-2025-003',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            _buildCustomerDetailsSection(size),

            SizedBox(height: 10),

            _buildProductsSection(products),

            SizedBox(height: 20),
            _buildTotalSection(
              totalProducts: 1,
              totalQty: 2,
              subTotal: 0.95,
              gstAmount: 0.05,
              cessAmount: 0.00,
              roundOff: double.nan, // This will show as NaN
              payableAmount: 1.00,
            ),

            //   _buildTotalSection(totalAmount),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerDetailsSection(Size size) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.green, size: 24),
                SizedBox(width: 8),
                Text(
                  'Customer Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                _buildDetailRow(
                  'Name',
                  "Jijumon",
                  Icons.account_circle,
                  size.width / 2.4,
                ),
                _buildDetailRow(
                  'Phone Number',
                  '9965129990',
                  Icons.phone,
                  size.width / 2.4,
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                _buildDetailRow(
                  'Email',
                  'test@gmail.com',
                  Icons.email,
                  size.width / 2.4,
                ),
                _buildDetailRow(
                  'Pincode',
                  '679308',
                  Icons.location_pin,
                  size.width / 2.4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsSection(List<Map<String, dynamic>> products) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.orange, size: 24),
                SizedBox(width: 8),
                Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ...products.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> product = entry.value;
              return Column(
                children: [
                  _buildProductCard(product, index + 1),
                  if (index < products.length - 1) SizedBox(height: 12),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    return CustomShadowContainer(
       radius: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product['image'] != null
                    ? Image.asset(
                        product['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[600],
                              size: 32,
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.shopping_bag,
                          color: Colors.grey[600],
                          size: 32,
                        ),
                      ),
              ),
            ),
            SizedBox(width: 10),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${product['productName']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${product['unit']}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product['productId']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Qty : ${product['qty']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '₹${product['price']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A1A1A),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        ' ₹${product['mrp']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF059669)],
                          ),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF10B981).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            '₹${product['netAmount']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection({
    required int totalProducts,
    required int totalQty,
    required double subTotal,
    required double gstAmount,
    required double cessAmount,
    required double roundOff,
    required double payableAmount,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary Details
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Total Products', '$totalProducts items'),
                  SizedBox(height: 8),
                  _buildSummaryRow('Total Qty', '$totalQty items'),
                  SizedBox(height: 8),
                  _buildSummaryRow(
                    'Sub Total',
                    '₹${subTotal.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 8),
                  _buildSummaryRow(
                    'GST Amount',
                    '₹${gstAmount.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 8),
                  _buildSummaryRow(
                    'Cess Amount',
                    '₹${cessAmount.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 8),
                  _buildSummaryRow(
                    'Round Off',
                    roundOff.isNaN
                        ? '₹ NaN'
                        : '₹${roundOff.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 12),
                  Divider(thickness: 1.5, color: Colors.grey[300]),
                  SizedBox(height: 8),
                  // Payable Amount (highlighted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payable Amount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      Text(
                        '₹${payableAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Alternative approach using Positioned for absolute bottom positioning
  // Widget buildWithPositionedTotal(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         // Main content
  //         Padding(
  //           padding: EdgeInsets.only(bottom: 200), // Reserve space for total section
  //           child: SingleChildScrollView(
  //             padding: EdgeInsets.all(16),
  //             child: Column(
  //               children: [
  //                 // Your products section and other content
  //                 _buildProductsSection(products),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // Total section positioned at absolute bottom
  //         Positioned(
  //           left: 0,
  //           right: 0,
  //           bottom: 0,
  //           child: _buildTotalSection(
  //             totalProducts: 1,
  //             totalQty: 2,
  //             subTotal: 0.95,
  //             gstAmount: 0.05,
  //             cessAmount: 0.00,
  //             roundOff: double.nan,
  //             payableAmount: 1.00,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
