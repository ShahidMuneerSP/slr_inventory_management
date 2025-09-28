// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/controller/customersController.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/model/customerListModel.dart'
    show CustomerListModel;
import 'package:slr_inventory_management/Utils/colors/colors.dart';

import 'package:slr_inventory_management/Utils/common/innerShadowTextField.dart';

class EditCustomerView extends StatefulWidget {
  const EditCustomerView({
    super.key,
    required this.customerName,
    required this.phone,
    required this.email,
    required this.pincode,
    required this.index,
  });
  final String customerName;
  final String phone;
  final String email;
  final String pincode;
  final int index;
  @override
  State<EditCustomerView> createState() => _EditCustomerViewState();
}

class _EditCustomerViewState extends State<EditCustomerView> {
  Customerscontroller customerscontroller = Get.find();
  @override
  void initState() {
    customerscontroller.editCustomerNameController.text = widget.customerName;
    customerscontroller.editPhoneController.text = widget.phone;
    customerscontroller.editEmailAddressController.text = widget.email;
    customerscontroller.editPincodeController.text = widget.pincode;
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
        title:  Text(
          "Edit Customer Details",
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
              controller: customerscontroller.editCustomerNameController,
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
              controller: customerscontroller.editPhoneController,
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
              controller: customerscontroller.editPincodeController,
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
              controller: customerscontroller.editEmailAddressController,
              title: "Email Address",
              keyboardType: TextInputType.number,
              readOnly: false,
              onTap: () {},
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              customerscontroller.customerList.removeAt(widget.index);
              customerscontroller.customerList.add(
                CustomerListModel(
                  name: customerscontroller.editCustomerNameController.text,
                  phoneNumber: customerscontroller.editPhoneController.text,
                  email: customerscontroller.editEmailAddressController.text,
                  pincode: customerscontroller.editPincodeController.text,
                ),
              );
              Get.back();
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
                        "Update",
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
