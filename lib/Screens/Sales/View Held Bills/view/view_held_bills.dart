// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class ViewHeldBills extends StatelessWidget {
  const ViewHeldBills({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "View Held Bills",
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
      ),
      body: Column(
        children: [
          Expanded(
            child: BillListView(
              bills: [
                BillData(
                  name: "Unknown",
                  createdBy: "Shahid",
                  billAmount: 1.00,
                  phone: "Unknown",
                  createdOn: "2025-09-24 19:44:37",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StandardBillCard extends StatelessWidget {
  final String name;
  final String createdBy;
  final double billAmount;
  final String phone;
  final String createdOn;
  final VoidCallback onAddToBilling;
  final VoidCallback onDelete;

  const StandardBillCard({
    super.key,
    required this.name,
    required this.createdBy,
    required this.billAmount,
    required this.phone,
    required this.createdOn,
    required this.onAddToBilling,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomShadowContainer(
        radius: 16,
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(16),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.1),
        //       spreadRadius: 1,
        //       blurRadius: 8,
        //       offset: const Offset(0, 2),
        //     ),
        //   ],
        // ),
        child: Column(
          children: [
            SizedBox(height: 10),
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  // Name and Amount
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                                fontFamily: "Geist",
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "₹${billAmount.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF10B981),
                                  fontFamily: "Geist",
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
            SizedBox(height: 5),
            // Phone Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [_buildInfoRow(label: "Phone", value: phone)],
              ),
            ),
            SizedBox(height: 10),
            // Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width / 2.4,
                    child: _buildInfoRow(label: "Created By", value: createdBy),
                  ),
                  SizedBox(
                    width: size.width / 2.4,
                    child: _buildInfoRow(
                      label: "Created On",
                      value: _formatDate(createdOn),
                    ),
                  ),
                ],
              ),
            ),

            // Date Info

            // Action Buttons
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: onAddToBilling,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBg,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_shopping_cart_outlined, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "ADD TO BILLING",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: "Geist",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onDelete,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFEF4444)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline, size: 20),
                          SizedBox(width: 4),
                          Text(
                            "DELETE",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: "Geist",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
            fontFamily: "Geist",
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
            fontFamily: "Geist",
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }
}

// Usage Example in ListView.builder
class BillListView extends StatelessWidget {
  final List<BillData> bills;

  const BillListView({super.key, required this.bills});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];
          return StandardBillCard(
            name: bill.name,
            createdBy: bill.createdBy,
            billAmount: bill.billAmount,
            phone: bill.phone,
            createdOn: bill.createdOn,
            onAddToBilling: () {
              // Handle add to billing
              log("Add to billing: ${bill.name}");
            },
            onDelete: () {
              // Handle delete
              log("Delete: ${bill.name}");
            },
          );
        },
      ),
    );
  }
}

// Data model
class BillData {
  final String name;
  final String createdBy;
  final double billAmount;
  final String phone;
  final String createdOn;

  BillData({
    required this.name,
    required this.createdBy,
    required this.billAmount,
    required this.phone,
    required this.createdOn,
  });
}

/////////////////////////////
///
// class CompactBillCard extends StatelessWidget {
//   final String name;
//   final String createdBy;
//   final double billAmount;
//   final String phone;
//   final String createdOn;
//   final VoidCallback onAddToBilling;
//   final VoidCallback onDelete;

//   const CompactBillCard({
//     super.key,
//     required this.name,
//     required this.createdBy,
//     required this.billAmount,
//     required this.phone,
//     required this.createdOn,
//     required this.onAddToBilling,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.08),
//             spreadRadius: 0,
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Header Section - Compact
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Small Avatar
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: AppColors.salesColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.person_outline,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Name and Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               name.isEmpty || name == "Unknown"
//                                   ? "Unknown Customer"
//                                   : name,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xFF1E293B),
//                                 fontFamily: "Geist",
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 2,
//                             ),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF10B981).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Text(
//                               "₹${billAmount.toStringAsFixed(2)}",
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF10B981),
//                                 fontFamily: "Geist",
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildCompactInfo(
//                               Icons.person_add_outlined,
//                               createdBy,
//                               const Color(0xFF6366F1),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _buildCompactInfo(
//                               Icons.phone_outlined,
//                               phone.isEmpty || phone == "Unknown"
//                                   ? "No phone"
//                                   : phone,
//                               const Color(0xFF059669),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       _buildCompactInfo(
//                         Icons.access_time_outlined,
//                         _formatDate(createdOn),
//                         const Color(0xFF7C3AED),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Action Buttons - Compact
//           Container(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: ElevatedButton(
//                     onPressed: onAddToBilling,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.salesColor,
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.add_shopping_cart_outlined, size: 16),
//                         SizedBox(width: 4),
//                         Text(
//                           "ADD TO BILL",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                             fontFamily: "Geist",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 OutlinedButton(
//                   onPressed: onDelete,
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: const Color(0xFFEF4444),
//                     side: const BorderSide(color: Color(0xFFEF4444), width: 1),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     minimumSize: Size.zero,
//                   ),
//                   child: const Icon(Icons.delete_outline, size: 16),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCompactInfo(IconData icon, String value, Color color) {
//     return Row(
//       children: [
//         Icon(icon, color: color, size: 14),
//         const SizedBox(width: 6),
//         Expanded(
//           child: Text(
//             value,
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Color(0xFF64748B),
//               fontFamily: "Geist",
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatDate(String dateString) {
//     try {
//       DateTime date = DateTime.parse(dateString);
//       return "${date.day}/${date.month}/${date.year}";
//     } catch (e) {
//       return dateString;
//     }
//   }
// }

// // Usage Example in ListView.builder
// class CompactBillListView extends StatelessWidget {
//   final List<BillData> bills;

//   const CompactBillListView({super.key, required this.bills});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFFF1F5F9),
//       child: ListView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         itemCount: bills.length,
//         itemBuilder: (context, index) {
//           final bill = bills[index];
//           return CompactBillCard(
//             name: bill.name,
//             createdBy: bill.createdBy,
//             billAmount: bill.billAmount,
//             phone: bill.phone,
//             createdOn: bill.createdOn,
//             onAddToBilling: () {
//               // Handle add to billing
//               print("Add to billing: ${bill.name}");
//             },
//             onDelete: () {
//               // Handle delete
//               print("Delete: ${bill.name}");
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // Data model
// class BillData {
//   final String name;
//   final String createdBy;
//   final double billAmount;
//   final String phone;
//   final String createdOn;

//   BillData({
//     required this.name,
//     required this.createdBy,
//     required this.billAmount,
//     required this.phone,
//     required this.createdOn,
//   });
// }
