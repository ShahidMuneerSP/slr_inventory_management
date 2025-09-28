

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/Add%20Customer%20Sale/view/add_customer_sale_view.dart';

class Addcustomersalecontroller extends GetxController {
  TextEditingController salesCustomerNameController = TextEditingController();
  FocusNode salesCustomerNameFocusNode = FocusNode();
  TextEditingController searchProductController = TextEditingController();
  //RxBool isCross = true.obs;
  RxBool isEmpty = true.obs;
  RxBool minimumLetter = true.obs;
  RxBool isFast = true.obs;
  RxString voiceText = ''.obs;
  // Existing variables...
  RxBool showSuggestions = false.obs;
  RxList<ProductSuggestion> searchSuggestions = <ProductSuggestion>[].obs;
  RxList<ProductSuggestion> filteredSuggestions = <ProductSuggestion>[].obs;
  RxBool isShowSalesCustomer = false.obs;
  RxBool isShowOrderSummary = false.obs;
  RxBool isShowCustimorInfo = false.obs;
  RxList<ProductSuggestion> addedProductList = <ProductSuggestion>[].obs;
 RxString  customerName  = "".obs;
 RxString customerPhone = "".obs;


  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy product suggestions
    loadSearchSuggestions();
  }
    double getTotalPayableAmount() {
    double total = 0;
    for (var product in addedProductList) {
      total += product.netAmount; // or however you store netAmount
    }
    
    return total;
  
  }

  // Method to update product net amount
  void updateProductNetAmount(String productCode, double newNetAmount) {
    // Find and update the product in your list
    final index = addedProductList.indexWhere((product) => product.productId == productCode);
    if (index != -1) {
      addedProductList[index].netAmount = newNetAmount;
      update(); // This will trigger UI rebuild
    }
  }

  void loadSearchSuggestions() {
    // Dummy product suggestions with detailed information
    searchSuggestions.addAll([
      ProductSuggestion(
        0.00,
        productName: 'Marvel PLUS',
        productId: "PRD-001",
        quantity: 8,
        price: 10.00,
        manufactureDate: '24-09-2025',
        unit: "L",
        mrp: 10.00,
      ),
      ProductSuggestion(
        0.00,
        productName: 'Marvel PLUS',
        productId: "PRD-002",
        quantity: 10,
        price: 10,
        manufactureDate: '20-09-2025',
        unit: "L",
        mrp: 10.00,
      ),
      ProductSuggestion(
        0.00,
        productName: 'Godrej Good Knight Power Active+ Refill 45ml',
        productId: "8901157001143",
        quantity: 15,
        price: 85.00,
        manufactureDate: '20-09-2025',
        unit: "Pcs",
        mrp: 85.00,
      ),
      ProductSuggestion(
        0.00,
        productName: 'Cinthol Original Bathing Soap 30g',
        productId: "8901023028779",
        quantity: 2,
        price: 10.00,
        manufactureDate: '20-09-2025',
        unit: "Pcs",
        mrp: 10.00,
      ),
      ProductSuggestion(
        0.00,
        productName: 'AASHIRVAAD SUPERIOR MP ATTA 1 KG',
        productId: "8901725121747",
        quantity: 22,
        price: 57.00,
        manufactureDate: '20-09-2025',
        unit: "Kg",
        mrp: 58.00,
      ),
      ProductSuggestion(
        0.00,
        productName:
            'Hit Flying Insect Killer - Mosquito & Fly Killer Spray 400ml',
        productId: "8901157025217",
        quantity: 2,
        price: 178.00,
        manufactureDate: '20-09-2025',
        unit: "Pcs	",
        mrp: 180.00,
      ),
    ]);
  }

  void filterSearchSuggestions(String query) {
    if (query.isEmpty) {
      filteredSuggestions.clear();
      return;
    }

    final filtered = searchSuggestions
        .where(
          (suggestion) => suggestion.productName.toLowerCase().contains(
            query.toLowerCase(),
          ),
        )
        .toList();

    filteredSuggestions.assignAll(filtered);
  }

  void performSearch(String searchTerm) {
    // Implement your actual search logic here
    print('Performing search for: $searchTerm');

    // Your existing search implementation
    // ...
  }

 
}
