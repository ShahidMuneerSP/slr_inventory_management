// ignore_for_file: deprecated_member_use, use_super_parameters, strict_top_level_inference, must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/Add%20Customer%20Sale/controller/addCustomerSaleController.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/Add%20Customer%20Sale/model/sales_customer.dart';
import 'package:slr_inventory_management/Screens/Sales/Sales%20Customer/widgets/Add%20Customer%20Sale/widgets/productSerachBarcodeScanner.dart';
import 'package:slr_inventory_management/Screens/Sales/View%20Held%20Bills/view/view_held_bills.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/avatarGlow.dart';

import 'package:icons_plus/icons_plus.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';
import 'package:slr_inventory_management/Utils/common/showToast.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:toastification/toastification.dart';

class AddCustomerSalesView extends StatefulWidget {
  const AddCustomerSalesView({super.key});

  @override
  State<AddCustomerSalesView> createState() => _AddCustomerSalesViewState();
}

class _AddCustomerSalesViewState extends State<AddCustomerSalesView> {
  Addcustomersalecontroller addcustomersalecontroller = Get.put(
    Addcustomersalecontroller(),
  );

  @override
  void initState() {
    addcustomersalecontroller.isShowSalesCustomer.value = false;
    addcustomersalecontroller.isShowOrderSummary.value = false;
    addcustomersalecontroller.isShowCustimorInfo.value = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: SalesCustomerAppBar(
        addcustomersalecontroller: addcustomersalecontroller,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RowTextFieldWidget(
                controllers: addcustomersalecontroller,
                type: "",
                id: "",
                sellType: "",
              ),
            ),
            SizedBox(height: 15),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: size.height / 2.8,
                minHeight: size.height / 2.8,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ListView.separated(
                    shrinkWrap: true,

                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        productName: product['name'],
                        productCode: product['code'],
                        quantity: product['quantity'],
                        unit: product['unit'],
                        mrp: product['mrp'],
                        price: product['price'],
                        onDelete: () => _deleteProduct(index),
                        onQuantityChanged: (newQuantity) =>
                            _updateQuantity(index, newQuantity),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 8);
                    },
                  ),
                ),
              ),
            ),

            // ConstrainedBox(
            //   constraints: BoxConstraints(maxHeight: size.height / 3,minHeight: size.height / 3,),
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     itemCount: products.length,
            //     itemBuilder: (context, index) {
            //       final product = products[index];
            //       return ProductCard(
            //         productName: product['name'],
            //         productCode: product['code'],
            //         quantity: product['quantity'],
            //         unit: product['unit'],
            //         mrp: product['mrp'],
            //         price: product['price'],
            //         onDelete: () => _deleteProduct(index),
            //         onQuantityChanged: (newQuantity) =>
            //             _updateQuantity(index, newQuantity),
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return SizedBox(height: 10);
            //     },
            //   ),
            // ),
             SizedBox(height: 15),
            ProfessionalCheckoutScreen(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product removed'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      products[index]['quantity'] = newQuantity;
    });
  }
}

class SalesCustomerAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Addcustomersalecontroller addcustomersalecontroller;

  const SalesCustomerAppBar({Key? key, required this.addcustomersalecontroller})
    : super(key: key);

  @override
  State<SalesCustomerAppBar> createState() => _SalesCustomerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SalesCustomerAppBarState extends State<SalesCustomerAppBar>
    with SingleTickerProviderStateMixin {
  bool _isSearchMode = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Dummy customer list (move this to your controller ideally)
  List<SalesCustomer> get dummyCustomers => [
    SalesCustomer(customerName: "John Doe", customerPhone: "9876543210"),
    SalesCustomer(customerName: "Jane Smith", customerPhone: "9876501234"),
    SalesCustomer(customerName: "Michael Johnson", customerPhone: "9123456789"),
    SalesCustomer(customerName: "Emily Brown", customerPhone: "9012345678"),
    SalesCustomer(customerName: "David Miller", customerPhone: "9345678901"),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearchMode() {
    setState(() {
      _isSearchMode = !_isSearchMode;
    });

    if (_isSearchMode) {
      _animationController.forward();
      // Auto focus on the text field
      Future.delayed(const Duration(milliseconds: 100), () {
        widget.addcustomersalecontroller.salesCustomerNameFocusNode
            .requestFocus();
      });
    } else {
      _animationController.reverse();

      widget.addcustomersalecontroller.salesCustomerNameFocusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_back, color: AppColors.white, size: 20),
        ),
      ),
      title: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return _isSearchMode
              ? FadeTransition(
                  opacity: _animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(_animation),
                    child: _buildSearchField(),
                  ),
                )
              : widget.addcustomersalecontroller.isShowSalesCustomer.value ==
                    true
              ? FadeTransition(
                  opacity: Tween<double>(begin: 1, end: 0).animate(_animation),
                  child: Text(
                    'Customer : ${widget.addcustomersalecontroller.salesCustomerNameController.text}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : SizedBox();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(_isSearchMode ? Icons.close : Icons.person_add),
          onPressed: _toggleSearchMode,
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: TypeAheadField<SalesCustomer>(
        loadingBuilder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: const CupertinoActivityIndicator(
              color: Colors.white,
              radius: 8,
            ),
          );
        },
        suggestionsCallback: (search) async {
          if (search.isEmpty) return [];

          return dummyCustomers
              .where(
                (c) =>
                    (c.customerName?.toLowerCase().contains(
                          search.toLowerCase(),
                        ) ??
                        false) ||
                    (c.customerPhone?.contains(search) ?? false),
              )
              .toList();
        },
        controller:
            widget.addcustomersalecontroller.salesCustomerNameController,
        focusNode: widget.addcustomersalecontroller.salesCustomerNameFocusNode,
        builder: (context, controller, focusNode) => TextFormField(
          keyboardType: TextInputType.name,
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: "Geist",
            color: Colors.white,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontFamily: "Geist",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
            hintText: "Search customer...",
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white.withOpacity(0.8),
                      size: 18,
                    ),
                    onPressed: () {
                      controller.clear();
                    },
                  )
                : null,
          ),
        ),
        decorationBuilder: (context, child) => Material(
          type: MaterialType.card,
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          shadowColor: Colors.black.withOpacity(0.2),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: child,
          ),
        ),
        itemBuilder: (context, SalesCustomer suggestion) => InkWell(
          onTap: () {
            // Auto close search mode after selection

            widget.addcustomersalecontroller.salesCustomerNameFocusNode
                .unfocus();
            widget.addcustomersalecontroller.salesCustomerNameController.text =
                suggestion.customerName ?? "";
            widget.addcustomersalecontroller.isShowSalesCustomer.value = true;
            _toggleSearchMode();

            // Show success feedback
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: ${suggestion.customerName}'),
                duration: const Duration(seconds: 2),
                backgroundColor: const Color(0xFF6366F1),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            setState(() {});
            log("Selected ${suggestion.customerName}>>");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: const Color(0xFF6366F1),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suggestion.customerName ?? "--",
                        style: const TextStyle(
                          fontFamily: "Geist",
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        suggestion.customerPhone ?? "--",
                        style: TextStyle(
                          fontFamily: "Geist",
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        debounceDuration: const Duration(milliseconds: 500),
        hideOnSelect: true,
        hideOnUnfocus: false,
        hideWithKeyboard: false,
        retainOnLoading: true,
        onSelected: (SalesCustomer? value) {
          if (value != null) {
            widget.addcustomersalecontroller.salesCustomerNameController.text =
                value.customerName ?? "";
            widget.addcustomersalecontroller.isShowSalesCustomer.value = true;
            widget.addcustomersalecontroller.salesCustomerNameFocusNode
                .unfocus();

            // Auto close search mode after selection
            _toggleSearchMode();

            // Show success feedback
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: ${value.customerName}'),
                duration: const Duration(seconds: 2),
                backgroundColor: const Color(0xFF6366F1),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );

            debugPrint("Selected ${value.customerName}");
          }
        },
      ),
    );
  }
}

// Alternative: Overlay approach for better UX
class SalesCustomerAppBarWithOverlay extends StatefulWidget
    implements PreferredSizeWidget {
  final Addcustomersalecontroller addcustomersalecontroller;

  const SalesCustomerAppBarWithOverlay({
    Key? key,
    required this.addcustomersalecontroller,
  }) : super(key: key);

  @override
  State<SalesCustomerAppBarWithOverlay> createState() =>
      _SalesCustomerAppBarWithOverlayState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SalesCustomerAppBarWithOverlayState
    extends State<SalesCustomerAppBarWithOverlay> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showSearchOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideSearchOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, kToolbarHeight),
          child: Material(
            elevation: 8,
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: SalesCustomerTextfiled(
                addcustomersalecontroller: widget.addcustomersalecontroller,
                size: MediaQuery.of(context).size,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AppBar(
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
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: AppColors.white, size: 20),
          ),
        ),
        title: const Text(
          'Sales Customer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              if (_overlayEntry == null) {
                _showSearchOverlay();
              } else {
                _hideSearchOverlay();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _hideSearchOverlay();
    super.dispose();
  }
}

class RowTextFieldWidget extends StatelessWidget {
  final Addcustomersalecontroller controllers;
  final String type;
  final String id;
  final String sellType;

  RowTextFieldWidget({
    super.key,
    required this.controllers,
    required this.type,
    required this.id,
    required this.sellType,
  });

  SpeechToText speechToText = SpeechToText();
  String voice = 'Search With Your Voice';
  String searchher = 'Search Here';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: const Color(0xffe7eef3),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: -const Offset(5, 5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Color(0xFFBFC9D5),
                        offset: Offset(4.5, 4.5),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 550),
                  curve: Curves.elasticOut,
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  child: TextField(
                    onChanged: (value) {
                      if (value.trim() != '') {
                        controllers.isEmpty.value = false;
                        controllers.minimumLetter.value = false;
                        // Trigger search suggestions
                        controllers.filterSearchSuggestions(value);
                        controllers.showSuggestions.value = true;
                      } else {
                        controllers.isEmpty.value = true;
                        controllers.showSuggestions.value = false;
                      }
                    },
                    onSubmitted: (value) {
                      if (value.trim() != '') {
                        controllers.isFast.value = false;
                        controllers.isEmpty.value = true;
                        controllers.minimumLetter.value = false;
                        controllers.showSuggestions.value = false;
                        // Perform actual search here
                        controllers.performSearch(value);
                      }
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(500)],
                    textInputAction: TextInputAction.done,
                    controller: controllers.searchProductController,
                    cursorColor: Color.fromARGB(255, 255, 189, 76),
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          Get.to(
                            Productserachbarcodescanner(
                              controllers: controllers,
                              type: type,
                              id: id,
                              sellType: sellType,
                            ),
                            transition: Transition.downToUp,
                          );
                        },
                        child: Icon(
                          BoxIcons.bx_barcode_reader,
                          size: 29,
                          color: Colors.black,
                        ),
                      ),

                      prefixIconConstraints: BoxConstraints(
                        minWidth: 8,
                        minHeight: 2,
                      ),
                      prefixIcon: IconButton(
                        icon: Icon(
                          BoxIcons.bx_microphone,
                          size: 26,
                          color: Colors.red[600],
                        ),
                        onPressed: () async {
                          // voiceSearch(context);
                          var available = speechToText.initialize();
                          if (await available) {
                            speechToText.listen(
                              onSoundLevelChange: (level) {},
                              listenFor: Duration(seconds: 10),
                              onResult: (result) {
                                controllers.voiceText.value =
                                    result.recognizedWords;
                                if (controllers.voiceText.value != '') {
                                  controllers.searchProductController.text =
                                      controllers.voiceText.value;
                                  speechToText.stop();
                                  controllers.isFast.value = false;
                                  controllers.isFast.refresh();
                                  controllers.voiceText.value = '';
                                  controllers.showSuggestions.value = false;
                                  Navigator.pop(context);
                                  // Perform search with voice input
                                  controllers.performSearch(
                                    controllers.searchProductController.text,
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10,
                      ),
                      hintText: 'Search Product',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xffe7eef3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Search Suggestions Container
        Obx(
          () =>
              controllers.showSuggestions.value &&
                  controllers.filteredSuggestions.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 200, // Limit height for scrolling
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controllers.filteredSuggestions.length > 5
                        ? 5 // Show max 5 suggestions
                        : controllers.filteredSuggestions.length,
                    itemBuilder: (context, index) {
                      final product = controllers.filteredSuggestions[index];
                      return InkWell(
                        onTap: () {
                          controllers.searchProductController.text =
                              product.productName;
                          controllers.showSuggestions.value = false;

                          controllers.isEmpty.value = false;
                          // Select the product and perform action
                          controllers.selectProduct(product);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "Qty : ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${product.quantity}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "Mfg Date : ",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          product.manufactureDate,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  product.price % 2 == 0
                                      ? "₹${product.price.toInt().toString()}"
                                      : "₹${product.price.toString()}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green[700],

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}

// Product Model Class
class ProductSuggestion {
  final String productName;
  final int quantity;
  final double price;
  final String manufactureDate;

  ProductSuggestion({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.manufactureDate,
  });

  String get displayText => productName;

  //String get detailsText => 'Qty: $quantity | ₹$price | MFD: $manufactureDate';
}

class SalesCustomerTextfiled extends StatefulWidget {
  const SalesCustomerTextfiled({
    super.key,
    required this.addcustomersalecontroller,
    required this.size,
  });

  final Addcustomersalecontroller addcustomersalecontroller;
  final Size size;

  @override
  State<SalesCustomerTextfiled> createState() => _SalesCustomerTextfiledState();
}

class _SalesCustomerTextfiledState extends State<SalesCustomerTextfiled> {
  // Dummy customer list
  List<SalesCustomer> get dummyCustomers => [
    SalesCustomer(customerName: "John Doe", customerPhone: "9876543210"),
    SalesCustomer(customerName: "Jane Smith", customerPhone: "9876501234"),
    SalesCustomer(customerName: "Michael Johnson", customerPhone: "9123456789"),
    SalesCustomer(customerName: "Emily Brown", customerPhone: "9012345678"),
    SalesCustomer(customerName: "David Miller", customerPhone: "9345678901"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffe7eef3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: -const Offset(5, 5),
            blurRadius: 6,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Color(0xFFBFC9D5),
            offset: Offset(4.5, 4.5),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TypeAheadField<SalesCustomer>(
        loadingBuilder: (context) {
          return const Center(
            child: CupertinoActivityIndicator(color: Color(0xFF6366F1)),
          );
        },
        suggestionsCallback: (search) async {
          if (search.isEmpty) return [];

          return dummyCustomers
              .where(
                (c) =>
                    (c.customerName?.toLowerCase().contains(
                          search.toLowerCase(),
                        ) ??
                        false) ||
                    (c.customerPhone?.contains(search) ?? false),
              )
              .toList();
        },
        controller:
            widget.addcustomersalecontroller.salesCustomerNameController,
        focusNode: widget.addcustomersalecontroller.salesCustomerNameFocusNode,
        builder: (context, controller, focusNode) => TextFormField(
          keyboardType: TextInputType.name,
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Enter Sales Customer name or mobile No';
            } else {
              return null;
            }
          },
          controller: controller,
          focusNode: focusNode,
          autofocus: false,
          style: const TextStyle(fontSize: 15, fontFamily: "Geist"),
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                widget.addcustomersalecontroller.salesCustomerNameController
                    .clear();
              },
              child: const Icon(
                Icons.close,
                size: 20,
                color: Color(0xFF6366F1),
              ),
            ),
            counter: const Offstage(),
            filled: true,
            fillColor: const Color(0xffe7eef3),

            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE7E7E7)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE7E7E7)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE7E7E7)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffE7E7E7)),
              borderRadius: BorderRadius.circular(16.0),
            ),
            hintStyle: const TextStyle(
              fontFamily: "Geist",
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color.fromARGB(255, 156, 184, 194),
            ),
            hintText: "Sales Customer Name or Mobile No",
          ),
        ),
        decorationBuilder: (context, child) => Material(
          type: MaterialType.card,
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
        itemBuilder: (context, SalesCustomer suggestion) => InkWell(
          onTap: () {
            widget.addcustomersalecontroller.salesCustomerNameFocusNode
                .unfocus();
            widget.addcustomersalecontroller.salesCustomerNameController.text =
                suggestion.customerName ?? "";
            widget.addcustomersalecontroller.isShowSalesCustomer.value = true;
            setState(() {});
            log("Selected ${suggestion.customerName}>>");
          },
          child: ListTile(
            title: Text(
              suggestion.customerName ?? "--",
              style: const TextStyle(
                fontFamily: "Geist",
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              suggestion.customerPhone ?? "--",
              style: const TextStyle(
                fontFamily: "Geist",
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
          ),
        ),
        debounceDuration: const Duration(milliseconds: 900),
        hideOnSelect: true,
        hideOnUnfocus: true,
        hideWithKeyboard: true,
        retainOnLoading: true,
        onSelected: (SalesCustomer? value) {
          widget.addcustomersalecontroller.salesCustomerNameController.text =
              value?.customerName ?? "";

          log(
            "Selected ${widget.addcustomersalecontroller.salesCustomerNameController.text}",
          );
        },
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String productName;
  final String productCode;
  final int quantity;
  final String unit;
  final double mrp;
  final double price;
  final VoidCallback? onDelete;
  final Function(int)? onQuantityChanged;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unit,
    required this.mrp,
    required this.price,
    this.onDelete,
    this.onQuantityChanged,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
    widget.onQuantityChanged?.call(_quantity);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      widget.onQuantityChanged?.call(_quantity);
    }
  }

  double get _netAmount => widget.price * _quantity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomShadowContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage("assets/Images/download.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.productCode,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onDelete,
                    icon: Icon(Icons.delete_outline, size: 20),
                    iconSize: 18,
                    constraints: const BoxConstraints(
                      minWidth: 25,
                      minHeight: 25,
                    ),
                    style: IconButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          '₹${widget.price.toStringAsFixed(0)}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        if (widget.mrp != widget.price)
                          Text(
                            '₹${widget.mrp.toStringAsFixed(0)}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.5),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.unit,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quantity controls
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: _quantity > 1 ? _decrementQuantity : null,
                          icon: const Icon(Icons.remove, size: 16),
                          iconSize: 16,
                          constraints: const BoxConstraints(
                            minWidth: 25,
                            minHeight: 25,
                          ),
                          style: IconButton.styleFrom(
                            foregroundColor: colorScheme.primary,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(minWidth: 24),
                          child: Text(
                            '$_quantity',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _incrementQuantity,
                          icon: const Icon(Icons.add, size: 16),
                          iconSize: 16,
                          constraints: const BoxConstraints(
                            minWidth: 25,
                            minHeight: 25,
                          ),
                          style: IconButton.styleFrom(
                            foregroundColor: colorScheme.primary,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Net amount
                  Text(
                    '₹${_netAmount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> products = [
  {
    'name': 'MARVEL PLUS',
    'code': 'PRD-001',
    'quantity': 1,
    'unit': 'L',
    'mrp': 1.00,
    'price': 1.00,
  },
  {
    'name': 'MARVEL PLUS',
    'code': 'PRD-002',
    'quantity': 8,
    'unit': 'L',
    'mrp': 10.00,
    'price': 8.00,
  },
  {
    'name': 'MARVEL PLUS',
    'code': 'PRD-003',
    'quantity': 5,
    'unit': 'L',
    'mrp': 5.00,
    'price': 1.00,
  },
];

class ProfessionalCheckoutScreen extends StatefulWidget {
  const ProfessionalCheckoutScreen({Key? key}) : super(key: key);

  @override
  State<ProfessionalCheckoutScreen> createState() =>
      _ProfessionalCheckoutScreenState();
}

class _ProfessionalCheckoutScreenState extends State<ProfessionalCheckoutScreen>
    with TickerProviderStateMixin {
  final Addcustomersalecontroller addcustomersalecontroller = Get.find();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String selectedPaymentMethod = 'cash';
  bool isProcessing = false;

  final Map<String, dynamic> orderData = {
    'totalItems': 1,
    'subTotal': 0.95,
    'gstAmount': 0.05,
    'discount': 0.00,
    'payableAmount': 1.00,
  };

  final Map<String, dynamic> customerData = {
    'name': 'Shahid Muneer',
    'phone': '9961297519',
    'email': 'test@gmail.com',
    'pincode': '679309',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _buildOrderSummaryCard(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                SizedBox(
                  width: size.width / 2.2,
                  child: _buildActionButton(
                    "View Held Bills",
                    Icons.receipt,
                    Colors.white,
                    AppColors.mainBg,
                    () {
                      Get.to(ViewHeldBills());
                    },
                  ),
                ),
                SizedBox(
                  width: size.width / 2.6,
                  child: _buildActionButton(
                    "Hold Bill",
                    Icons.post_add,
                    Colors.white,
                    AppColors.mainBg,
                    () {
                      showToast(
                        context,
                        "Success",
                        "Bill Hold Successfully",
                        ToastificationType.success,
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildPaymentMethodCard(),
            const SizedBox(height: 15),
            _buildCustomerInfoCard(addcustomersalecontroller),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    final Addcustomersalecontroller addcustomersalecontroller = Get.find();
    return Card(
      color: const Color(0xFFF8F9FF),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: Color(0xFF4CAF50),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Spacer(),
                Obx(
                  () => InkWell(
                    onTap: () {
                      if (addcustomersalecontroller.isShowOrderSummary.value ==
                          true) {
                        addcustomersalecontroller.isShowOrderSummary.value =
                            false;
                      } else {
                        addcustomersalecontroller.isShowOrderSummary.value =
                            true;
                      }
                    },
                    child:
                        addcustomersalecontroller.isShowOrderSummary.value ==
                            true
                        ? Icon(Icons.arrow_drop_down)
                        : Icon(Icons.arrow_drop_up),
                  ),
                ),
              ],
            ),
            Obx(
              () => addcustomersalecontroller.isShowOrderSummary.value == true
                  ? const SizedBox(height: 16)
                  : SizedBox(),
            ),

            // Summary rows
            Obx(
              () => addcustomersalecontroller.isShowOrderSummary.value == true
                  ? _buildSummaryRow(
                      'Total Products',
                      '${orderData['totalItems']} items',
                    )
                  : SizedBox(),
            ),
            Obx(
              () => addcustomersalecontroller.isShowOrderSummary.value == true
                  ? _buildSummaryRow(
                      'Sub Total',
                      '₹${orderData['subTotal'].toStringAsFixed(2)}',
                    )
                  : SizedBox(),
            ),
            Obx(
              () => addcustomersalecontroller.isShowOrderSummary.value == true
                  ? _buildSummaryRow(
                      'GST Amount',
                      '₹${orderData['gstAmount'].toStringAsFixed(2)}',
                    )
                  : SizedBox(),
            ),
            Obx(
              () => addcustomersalecontroller.isShowOrderSummary.value == true
                  ? _buildSummaryRow(
                      'Discount',
                      '₹${orderData['discount'].toStringAsFixed(2)}',
                      isDiscount: true,
                    )
                  : SizedBox(),
            ),
            const Divider(color: Color(0xFFE0E0E0), thickness: 1, height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade50,
                    Colors.blue.shade100.withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payable Amount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '₹${orderData['payableAmount'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDiscount && orderData['discount'] == 0.00
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Card(
      color: const Color(0xFFF8F9FF),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.payment,
                    color: Color(0xFF2196F3),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Payment method grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.2,
              children: [
                _buildPaymentMethodTile(
                  'cash',
                  Icons.money,
                  'Cash',
                  const Color(0xFF4CAF50),
                ),
                _buildPaymentMethodTile(
                  'card',
                  Icons.credit_card,
                  'Card',
                  const Color(0xFF2196F3),
                ),
                _buildPaymentMethodTile(
                  'upi',
                  Icons.smartphone,
                  'UPI',
                  const Color(0xFF9C27B0),
                ),
                _buildPaymentMethodTile(
                  'credit',
                  Icons.account_balance,
                  'CREDIT',
                  const Color(0xFFFF9800),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(
    String method,
    IconData icon,
    String label,
    Color color,
  ) {
    bool isSelected = selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : const Color(0xFF666666),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : const Color(0xFF666666),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoCard(
    Addcustomersalecontroller addCustomerSaleController,
  ) {
    return Card(
      color: const Color(0xFFF8F9FF),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9C27B0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF9C27B0),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Customer Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Spacer(),
                Obx(
                  () => InkWell(
                    onTap: () {
                      if (addCustomerSaleController.isShowCustimorInfo.value ==
                          true) {
                        addCustomerSaleController.isShowCustimorInfo.value =
                            false;
                      } else {
                        addCustomerSaleController.isShowCustimorInfo.value =
                            true;
                      }
                    },
                    child:
                        addCustomerSaleController.isShowCustimorInfo.value ==
                            true
                        ? Icon(Icons.arrow_drop_down)
                        : Icon(Icons.arrow_drop_up),
                  ),
                ),
              ],
            ),
            Obx(
              () => addCustomerSaleController.isShowCustimorInfo.value == true
                  ? const SizedBox(height: 16)
                  : SizedBox(),
            ),

            // Customer info rows
            Obx(
              () => addCustomerSaleController.isShowCustimorInfo.value == true
                  ? _buildInfoRow(
                      'Name',
                      customerData['name'],
                      Icons.person_outline,
                    )
                  : SizedBox(),
            ),
            Obx(
              () => addCustomerSaleController.isShowCustimorInfo.value == true
                  ? _buildInfoRow(
                      'Phone',
                      customerData['phone'],
                      Icons.phone_outlined,
                    )
                  : SizedBox(),
            ),
            Obx(
              () => addCustomerSaleController.isShowCustimorInfo.value == true
                  ? _buildInfoRow(
                      'Email',
                      customerData['email'],
                      Icons.email_outlined,
                    )
                  : SizedBox(),
            ),
            Obx(
              () => addCustomerSaleController.isShowCustimorInfo.value == true
                  ? _buildInfoRow(
                      'Pincode',
                      customerData['pincode'],
                      Icons.location_on_outlined,
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF666666), size: 18),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'Clear All',
            Icons.clear_all,
            Colors.white,
            const Color(0xFFE53E3E),
            () {},

            isOutlined: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: _buildActionButton(
            isProcessing ? 'Processing...' : 'Checkout',
            isProcessing ? Icons.hourglass_empty : Icons.check_circle,
            Colors.white,
            const Color(0xFF4CAF50),
            isProcessing ? null : () => _processCheckout(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color textColor,
    Color buttonColor,
    VoidCallback? onPressed, {
    bool isOutlined = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.white : buttonColor,
        borderRadius: BorderRadius.circular(12),
        border: isOutlined ? Border.all(color: buttonColor, width: 1.5) : null,
        boxShadow: isOutlined
            ? null
            : [
                BoxShadow(
                  color: buttonColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isOutlined ? buttonColor : textColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isOutlined ? buttonColor : textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _processCheckout() {
    setState(() => isProcessing = true);
    HapticFeedback.heavyImpact();

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isProcessing = false);
        _showSuccessDialog();
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been processed successfully with ${selectedPaymentMethod.toUpperCase()} payment.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCustomorSaleVoiceSearch extends StatelessWidget {
  const AddCustomorSaleVoiceSearch({
    super.key,
    required this.voice,
    required this.controllers,
    required this.speechToText,
    required this.runtimeType,
    required this.type,
    required this.id,
    required this.sellType,
  });
  final String type;
  final String id;
  final String sellType;
  final String voice;
  final Addcustomersalecontroller controllers;
  final SpeechToText speechToText;
  final Type runtimeType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        voice,
        style: TextStyle(
          fontFamily: "Geist",
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarGlow(
              animate: true,
              repeat: true,
              glowColor: Color.fromARGB(255, 111, 111, 111),
              // glowBorderRadius: BorderRadius.circular(75),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6366F1),
                ),
                child: Icon(Icons.mic, color: Colors.white),
              ),
            ),
            Obx(
              () => controllers.voiceText.value == ''
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LottieBuilder.asset(
                        'assets/Lottie/animation_lnfkzpsr.json',
                      ),
                    )
                  : speechToText.hasError
                  ? InkWell(
                      onTap: () {
                        speechToText.initialize();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        child: Icon(Icons.refresh),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          controllers.voiceText.value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: Get.width / 3.2,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: Color.fromARGB(255, 111, 111, 111),
                    onPressed: () {
                      Navigator.pop(context);
                      speechToText.stop();
                      controllers.voiceText.value = '';
                    },
                    child: Text('Close', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: Get.width / 3.2,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: const Color(0xFF6366F1),
                    onPressed: () {
                      speechToText.listen(
                        onResult: (result) {
                          print(result.recognizedWords);
                          print(result.confidence);
                          print(result.runtimeType);
                          controllers.voiceText.value = result.recognizedWords;
                          if (controllers.voiceText.value != '') {
                            controllers.searchProductController.text =
                                controllers.voiceText.value;
                            speechToText.stop();

                            controllers.isFast.value = false;
                            controllers.isFast.refresh();

                            controllers.voiceText.value = '';
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Retry', style: TextStyle(color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.refresh, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
