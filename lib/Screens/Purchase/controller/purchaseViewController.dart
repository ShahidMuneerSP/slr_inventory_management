import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Purchase/model/purchase_model.dart';

class Purchaseviewcontroller extends GetxController {
  RxList<PurchaseModel> purchaseList = [
    PurchaseModel(
      invoiceNumber: "d.1245",
      sellers: "dinnies 1",
      amount: "1062",
      createdBy: "Anuvar",
      approvedBy: "Anuvar",
      createdAt: "28-09-2025 1:24 PM",
      approvedAt: "28-09-2025 1:25 PM",
      status: "Approved",
    ),
     PurchaseModel(
      invoiceNumber: "B-182525001305",
      sellers: "MATHA AGENCIES 1",
      amount: "6658",
      createdBy: "staff3",
      approvedBy: "Anuvar",
      createdAt: "30-06-2025 5:24 PM",
      approvedAt: "30-06-2025 5:50 PM",
      status: "Pending",
    ),
     PurchaseModel(
      invoiceNumber: "MA23",
      sellers: "MARKET WORTH TRADERS",
      amount: "925",
      createdBy: "staff2",
      approvedBy: "Anuvar",
      createdAt: "30-06-2025 3:24 PM",
      approvedAt: "30-06-2025 3:52 PM",
      status: "Approved",
    ),
     PurchaseModel(
      invoiceNumber: "DINNIES OLD STOCK 58",
      sellers: "dinnies 1",
      amount: "2544",
      createdBy: "staff1",
      approvedBy: "Anuvar",
      createdAt: "30-06-2025 4:24 PM",
      approvedAt: "30-06-2025 4:50 PM",
      status: "Rejected",
    ),
  ].obs;
}
