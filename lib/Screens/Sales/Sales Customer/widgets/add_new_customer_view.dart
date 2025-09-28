// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/controller/customersController.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/model/customerListModel.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/innerShadowTextField.dart';
import 'package:slr_inventory_management/Utils/common/showToast.dart';
import 'package:toastification/toastification.dart';

class AddNewCustomerView extends StatefulWidget {
  const AddNewCustomerView({super.key});

  @override
  State<AddNewCustomerView> createState() => _AddNewCustomerViewState();
}

class _AddNewCustomerViewState extends State<AddNewCustomerView> {
  Customerscontroller customerscontroller = Get.find();
  @override
  void initState() {
    customerscontroller.customerNameController.clear();
    customerscontroller.phoneController.clear();
    customerscontroller.emailAddressController.clear();
    customerscontroller.pincodeController.clear();
    super.initState();
  }

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
          "Add New Customer",
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
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InnerShadowTextField(
              hintText: "Customer Name",
              controller: customerscontroller.customerNameController,
              title: "Customer Name*",
              keyboardType: TextInputType.name,
              readOnly: false,
              onTap: () {},
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InnerShadowTextField(
              hintText: "Phone",
              controller: customerscontroller.phoneController,
              title: "Phone",
              keyboardType: TextInputType.number,
              readOnly: false,
              onTap: () {},
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InnerShadowTextField(
              hintText: "Pincode",
              controller: customerscontroller.pincodeController,
              title: "Pincode",
              keyboardType: TextInputType.number,
              readOnly: false,
              onTap: () {},
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InnerShadowTextField(
              hintText: "Email Address",
              controller: customerscontroller.emailAddressController,
              title: "Email Address",
              keyboardType: TextInputType.number,
              readOnly: false,
              onTap: () {},
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              if (customerscontroller.customerNameController.text.isEmpty) {
                showToast(
                  context,
                  "Warning",
                  "Please enter the Customer Name",
                  ToastificationType.warning,
                );
              } else if (customerscontroller.phoneController.text.isEmpty) {
                showToast(
                  context,
                  "Warning",
                  "Please enter the Phone Number",
                  ToastificationType.warning,
                );
              } else {
                customerscontroller.customerList.add(
                  CustomerListModel(
                    name: customerscontroller.customerNameController.text,
                    phoneNumber: customerscontroller.phoneController.text,
                    email: customerscontroller.emailAddressController.text,
                    pincode: customerscontroller.pincodeController.text,
                  ),
                );
                Get.back();
              }
            },
            child: Center(
              child: Container(
                height: 45,
                width: size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.mainBg,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Save",
                        style: TextStyle(
                          fontFamily: "Geist",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
