// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/view/customers_view.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/Add%20Customer%20Sale/view/add_customer_sale_view.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/customer_sale_detailed_view.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class SalesCustomerPage extends StatelessWidget {
  const SalesCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchSection(),
          Expanded(child: _buildSalesList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddCustomerSalesView());
        },
        backgroundColor: AppColors.mainBg,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.appbarBlueGradient),
        ),
      ),
      backgroundColor: AppColors.commonDarkestBlue,

      iconTheme: IconThemeData(color: AppColors.white),

      title: Text(
        "Customer Sales",
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
      elevation: 0.5,
      shadowColor: Colors.black.withOpacity(0.1),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 10),
          child: ElevatedButton.icon(
            onPressed: () {
              Get.to(CustomersView());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 0,
            ),

            label: const Text(
              "Customers",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search Customer Name or Invoice No",
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.grey.shade400,
                size: 22,
              ),
              filled: true,
              fillColor: const Color(0xFFF8F9FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF6366F1),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesList() {
    return ListView.separated(
      itemCount: salesData.length,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final sale = salesData[index];
        return InkWell(
          onTap: () {
            Get.to(CustomerSaleDetailedView());
          },
          child: _buildSaleCard(sale, context),
        );
      },
    );
  }

  Widget _buildSaleCard(Map<String, String> sale, context) {
    return CustomShadowContainer(
       radius: 16,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                top: 12,
                bottom: 12,
                left: 15,
                right: 5,
              ),
              //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sale['invoice']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sale['customer']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 107, 169, 200),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: sale['paymentType'] == 'Cash'
                                  ? const Color(0xFFDCFCE7)
                                  : const Color(0xFFDBEAFE),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              sale['paymentType']!,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: sale['paymentType'] == 'Cash'
                                    ? const Color(0xFF059669)
                                    : const Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "₹${sale['amount']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ],
                      ),

                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          switch (value) {
                            case 'edit':
                              // Handle edit action
                              _handleEdit();
                              break;
                            case 'delete':
                              // Show confirmation dialog before delete
                              _showDeleteConfirmation(context);
                              break;
                          }
                        },
                        icon: Icon(
                          Icons.more_vert,
                          size: 24,
                          color: Theme.of(
                            context,
                          ).iconTheme.color?.withOpacity(0.7),
                        ),
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Theme.of(context).cardColor,
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'edit',
                            height: 48,
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              leading: Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'delete',
                            height: 48,
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              leading: Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: Theme.of(context).colorScheme.error,
                              ),
                              title: Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Created By : ${sale["createdBy"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          sale["createdOn"]!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods (add these to your widget class)
  void _handleEdit() {
    // Your edit logic here
    print('Edit action triggered');
  }

  void _showDeleteConfirmation(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Confirm Delete',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete this item? This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleDelete();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleDelete() {
    // Your delete logic here
    print('Item deleted');
  }
}

// Enhanced dummy data with more realistic entries
final List<Map<String, String>> salesData = [
  {
    "invoice": "INV-2025-001",
    "customer": "Jijumon K.",
    "amount": "2,450",
    "paymentType": "Cash",
    "createdBy": "Shahid A.",
    "createdOn": "20-09-2025 3:38 PM",
  },
  {
    "invoice": "INV-2025-002",
    "customer": "Sonia P.",
    "amount": "1,500",
    "paymentType": "Card",
    "createdBy": "Aisha M.",
    "createdOn": "20-09-2025 11:38 PM",
  },
  {
    "invoice": "INV-2025-003",
    "customer": "Sreenath R.",
    "amount": "3,750",
    "paymentType": "Cash",
    "createdBy": "Shahid A.",
    "createdOn": "20-09-2025 5:45 PM",
  },
  {
    "invoice": "INV-2025-004",
    "customer": "Priya S.",
    "amount": "890",
    "paymentType": "Card",
    "createdBy": "Rahul K.",
    "createdOn": "20-09-2025 4:33 PM",
  },
  {
    "invoice": "INV-2025-005",
    "customer": "Michael Brown",
    "amount": "5,200",
    "paymentType": "Cash",
    "createdBy": "Emily J.",
    "createdOn": "20-09-2025 3:38 PM",
  },
  {
    "invoice": "INV-2025-006",
    "customer": "Sarah Davis",
    "amount": "1,850",
    "paymentType": "Card",
    "createdBy": "Jessica M.",
    "createdOn": "20-09-2025 1:30 PM",
  },
];
