import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:slr_inventory_management/Screens/Purchase/controller/purchaseViewController.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
import 'package:slr_inventory_management/Utils/common/customcard.dart';

class PurchaseView extends StatefulWidget {
  PurchaseView({super.key});

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  Purchaseviewcontroller purchaseviewcontroller = Get.put(
    Purchaseviewcontroller(),
  );

  var hintex = ['Search Here', "Invoice Number", "Sellers"];

  var ind = 0;

  late Timer timer;

  Future hintTime() async {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        ind = (ind + 1) % hintex.length;
      });
    });
  }

  @override
  void initState() {
    hintTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.appbarBlueGradient),
          ),
        ),
        backgroundColor: AppColors.commonDarkestBlue,
        iconTheme: IconThemeData(color: AppColors.white),
        automaticallyImplyLeading: false,
        title: Text(
          "Purchase",
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: CustomShadowContainer(
              width: MediaQuery.of(context).size.width,
              height: 45,
              radius: 10,
              child: TextField(
                readOnly: false,
                onTap: () {},
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Geist",
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintex[ind],
                  hintStyle: const TextStyle(
                    fontFamily: "Geist",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(BoxIcons.bx_search, size: 25),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Flexible(
            child: Obx(
              () => ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 0.5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: size.width / 1.6,
                              child: Text(
                                purchaseviewcontroller
                                    .purchaseList[index]
                                    .invoiceNumber
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.commonDarkestBlue,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    purchaseviewcontroller
                                            .purchaseList[index]
                                            .status ==
                                        "Approved"
                                    ? Color.fromARGB(255, 34, 136, 35)
                                    : purchaseviewcontroller
                                              .purchaseList[index]
                                              .status ==
                                          "Rejected"
                                    ? Color.fromARGB(255, 209, 24, 24)
                                    : Color.fromARGB(255, 170, 144, 26),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                purchaseviewcontroller
                                    .purchaseList[index]
                                    .status
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Sellers: ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              purchaseviewcontroller.purchaseList[index].sellers
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mainBg,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Amount: ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              purchaseviewcontroller.purchaseList[index].amount
                                  .toString(),
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Created By: ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              purchaseviewcontroller
                                  .purchaseList[index]
                                  .createdBy
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Approved By : ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              purchaseviewcontroller
                                  .purchaseList[index]
                                  .approvedBy
                                  .toString(),
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Created At: ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: size.width / 1.9,
                              child: Text(
                                purchaseviewcontroller
                                    .purchaseList[index]
                                    .createdAt
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Approved At: ",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              purchaseviewcontroller
                                  .purchaseList[index]
                                  .approvedAt
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: purchaseviewcontroller.purchaseList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
