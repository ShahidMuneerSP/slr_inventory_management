import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Customers/model/customerListModel.dart';

class Customerscontroller extends GetxController {
  RxList<CustomerListModel> customerList = [
    CustomerListModel(
      name: "Jafis",
      email: "jafis@gmail.com",
      phoneNumber: "8921253955",
      pincode: "679301",
    ),
    CustomerListModel(
      name: "Vishnu Vijayan",
      email: "vishnuvijayan@gmail.com",
      phoneNumber: "8111253955",
      pincode: "679302",
    ),
    CustomerListModel(
      name: "Elvin Johnson",
      email: "elvin@gmail.com",
      phoneNumber: "9961297519",
      pincode: "679303",
    ),
    CustomerListModel(
      name: "Akshay",
      email: "akshay@gmail.com",
      phoneNumber: "9988779898",
      pincode: "679304",
    ),
       CustomerListModel(
      name: "Anvarsha",
      email: "anvar@gmail.com",
      phoneNumber: "8988729891",
      pincode: "679305",
    ),
  ].obs;

  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneController  = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();


  TextEditingController editCustomerNameController = TextEditingController();
  TextEditingController editPhoneController  = TextEditingController();
  TextEditingController editPincodeController = TextEditingController();
  TextEditingController editEmailAddressController = TextEditingController();
}
