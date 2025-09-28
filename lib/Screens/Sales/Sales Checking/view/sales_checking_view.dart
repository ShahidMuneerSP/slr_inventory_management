import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class SalesCheckScreen extends StatefulWidget {
  const SalesCheckScreen({super.key});

  @override
  State<SalesCheckScreen> createState() => _SalesCheckScreenState();
}

class _SalesCheckScreenState extends State<SalesCheckScreen> {
  bool _isScanning = false;
  Map<String, dynamic>? _orderData;
  bool _isLoading = false;

  Future<void> fetchOrderDetails(String orderId) async {
    setState(() {
      _isLoading = true;
    });

    // 👇 Replace with your API endpoint
    final response = await http.get(
      Uri.parse("https://yourapi.com/orders/$orderId"),
    );

    if (response.statusCode == 200) {
      setState(() {
        _orderData = jsonDecode(response.body);
        _isScanning = false;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Order not found")));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> markAsDelivered(String orderId) async {
    final response = await http.post(
      Uri.parse("https://yourapi.com/orders/$orderId/deliver"),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order marked as delivered ✅")),
      );
      setState(() {
        _orderData?['status'] = 'delivered';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update order status ❌")),
      );
    }
  }

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
          "Sales Check",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
      ),
      body: _isScanning
          ? buildQRScanner()
          : _isLoading
          ? const Center(child: CircularProgressIndicator())
          : buildOrderDetails(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isScanning = true;
          });
        },
        backgroundColor: AppColors.mainBg,
        child: Icon(Icons.qr_code, color: Colors.white),
      ),
    );
  }

  // 📷 QR Scanner View
  Widget buildQRScanner() {
    return Stack(
      children: [
        MobileScanner(
          onDetect: (barcodeCapture) {
            final String? code = barcodeCapture.barcodes.first.rawValue;
            if (code != null) {
              fetchOrderDetails(code);
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _isScanning = false),
              icon: const Icon(Icons.cancel),
              label: const Text("Cancel"),
            ),
          ),
        ),
      ],
    );
  }

  // 📦 Order Details View
  Widget buildOrderDetails() {
    if (_orderData == null) {
      return const Center(child: Text("No order found"));
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order ID: ${_orderData!['id']}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("Product: ${_orderData!['product_name']}"),
          Text("Quantity: ${_orderData!['quantity']}"),
          Text("Total: ₹${_orderData!['total']}"),
          Text("Status: ${_orderData!['status']}"),
          const Spacer(),
          if (_orderData!['status'] == 'sale_completed')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.local_shipping),
                label: const Text("Mark as Delivered"),
                onPressed: () => markAsDelivered(_orderData!['id'].toString()),
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: const Text("Scan Another"),
              onPressed: () {
                setState(() {
                  _orderData = null;
                  _isScanning = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
