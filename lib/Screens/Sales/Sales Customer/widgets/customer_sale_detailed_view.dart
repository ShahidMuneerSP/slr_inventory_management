// ignore_for_file: deprecated_member_use, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class CustomerSaleDetailedView extends StatefulWidget {
  const CustomerSaleDetailedView({super.key, required this.invoiceNumber});
  final String invoiceNumber;

  @override
  State<CustomerSaleDetailedView> createState() =>
      _CustomerSaleDetailedViewState();
}

class _CustomerSaleDetailedViewState extends State<CustomerSaleDetailedView>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Start from right
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDetails() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

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
      {
        'productName': 'Marvel PLUS',
        'productId': 'PRD-002',
        'image': "assets/Images/download.jpeg",
        'qty': 8,
        'unit': 'L',
        'mrp': 12,
        'price': 10,
        'netAmount': 10,
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
          widget.invoiceNumber,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _toggleDetails();
            },
            icon: _isExpanded ? Icon(Icons.close) : Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRect(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _isExpanded
                            ? Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: _buildCustomerDetailsSection(size),
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  _buildProductsSection(products),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          _buildTotalSection(
            totalProducts: 2,
            totalQty: 9,
            subTotal: 0.00,
            gstAmount: 0.00,
            cessAmount: 0.00,
            roundOff: double.nan, // This will show as NaN
            payableAmount: 11,
          ),
        ],
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
    return CustomShadowContainer(
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
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
            SizedBox(height: 15),
            products.isEmpty
                ? Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: LottieBuilder.asset(
                        'assets/Lottie/animation_lnfjavmt.json',
                      ),
                    ),
                  )
                : ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(products[index], index + 1);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCompactStat(
                      label: 'Products',
                      value: '$totalProducts',
                    ),

                    _buildCompactStat(label: 'Quantity', value: '$totalQty'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),

              isShow== true?  SizedBox(height: 15):SizedBox(),

                // Price Breakdown - Collapsible
               isShow== true? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _buildPriceRow('Subtotal', subTotal, isRegular: true),
                      SizedBox(height: 10),
                      _buildPriceRow('GST', gstAmount, isRegular: true),

                      SizedBox(height: 10),
                      _buildPriceRow('Cess', cessAmount, isRegular: true),

                      SizedBox(height: 10),
                      _buildPriceRow(
                        'Round Off',
                        roundOff,
                        isRegular: true,
                        color: roundOff > 0 ? Colors.green : Colors.red,
                      ),
                    ],
                  ),)
                :SizedBox(),

                SizedBox(height: 20),

                // Grand Total - Prominent
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.appbarBlueGradient,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payable Amount',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5,
                        ),
                      ),

                      Text(
                        payableAmount % 2 == 0
                            ? payableAmount.toInt().toString()
                            : '₹${payableAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Compact Stat Widget
  Widget _buildCompactStat({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper: Price Row
  Widget _buildPriceRow(
    String label,
    double amount, {
    bool isRegular = false,
    Color? color,
  }) {
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
          amount.isNaN ? '₹ NaN' : '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerDetailsSection(Size size) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),

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
}
