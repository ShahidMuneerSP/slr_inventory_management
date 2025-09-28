// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/controller/customersController.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/add_new_customer_view.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/edit_customer_view.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class CustomersView extends StatelessWidget {
  CustomersView({super.key});
  Customerscontroller customerscontroller = Get.put(Customerscontroller());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
          "Customers",
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
                Get.to(AddNewCustomerView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                elevation: 0,
              ),

              label: const Text(
                "Add Customer",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Obx(
            () => Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomShadowContainer(
                      radius: 16,

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildDetailRow(
                                  'Name',
                                  "${customerscontroller.customerList[index].name}",
                                  Icons.account_circle,
                                  size.width / 2.2,
                                ),
                                SizedBox(width: 10),
                                _buildDetailRow(
                                  'Phone Number',
                                  '${customerscontroller.customerList[index].phoneNumber}',
                                  Icons.phone,
                                  size.width / 3.5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      EditCustomerView(
                                        customerName: customerscontroller
                                            .customerList[index]
                                            .name
                                            .toString(),
                                        email: customerscontroller
                                            .customerList[index]
                                            .email
                                            .toString(),
                                        index: index,
                                        phone: customerscontroller
                                            .customerList[index]
                                            .phoneNumber
                                            .toString(),
                                        pincode: customerscontroller
                                            .customerList[index]
                                            .pincode
                                            .toString(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 192, 219, 236),
                                      shape: BoxShape.circle,
                                    ),
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(5),
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.edit_square,
                                            color: Color.fromARGB(
                                              255,
                                              22,
                                              107,
                                              160,
                                            ),
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            Row(
                              children: [
                                _buildDetailRow(
                                  'Email',
                                  '${customerscontroller.customerList[index].email}',
                                  Icons.email,
                                  size.width / 2.2,
                                ),
                                SizedBox(width: 10),
                                _buildDetailRow(
                                  'Pincode',
                                  '${customerscontroller.customerList[index].pincode}',
                                  Icons.location_pin,
                                  size.width / 2.6,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: customerscontroller.customerList.length,
              ),
            ),
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
}
