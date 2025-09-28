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

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy product suggestions
    loadSearchSuggestions();
  }

  void loadSearchSuggestions() {
    // Dummy product suggestions with detailed information
    searchSuggestions.addAll([
      ProductSuggestion(
        productName: 'Marvel PLUS',
        quantity: 8,
        price: 10.0,
        manufactureDate: '24-09-2025',
      ),
      ProductSuggestion(
        productName: 'Marvel PLUS',
        quantity: 1,
        price: 10,
        manufactureDate: '20-09-2025',
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

  void selectProduct(ProductSuggestion product) {
    // Handle product selection
    print('Selected product: ${product.productName}');
    print('Quantity: ${product.quantity}, Price: ${product.price}');
    print('Manufacture Date: ${product.manufactureDate}');

    // Add your product selection logic here
    // For example, add to cart, show product details, etc.
  }
}
