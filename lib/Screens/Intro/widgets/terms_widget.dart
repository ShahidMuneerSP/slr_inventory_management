// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Intro/controller/introController.dart';
import 'package:slr_inventory_management/Screens/Intro/widgets/introScreenDefault.dart';
import 'package:slr_inventory_management/Screens/Intro/widgets/privacyPolicy.dart';
import 'package:slr_inventory_management/Screens/Intro/widgets/purchaseLoadingWidget.dart';
import 'package:slr_inventory_management/Screens/Intro/widgets/termsOfUse.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:slr/controller/controllers.dart';
// import 'package:slr/utils/color.dart';
// import 'package:slr/view/forms/widget/stepone.dart';
// import 'package:slr/view/getstart/introslider/introslider.dart';
// import 'package:slr/view/getstart/widget/terms_of_use.dart';
// import 'package:slr/view/main/pages/privacy_policy.dart';
// import 'package:slr/view/main/pages/wallet/pages/dashboard/pages/purchase/page/purchase_product_list.dart';
// import 'package:slr/view/user/mainuser/signup_or_login_page.dart';
// import 'package:slr/view/user/signup/sign_up_screen.dart';

class TermsWidget extends StatelessWidget {
  TermsWidget({super.key});

  final Introcontroller contrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // title: Text('Terms of use'),
        content: contrl.loading.value == true
            ? PurchaseLoadingWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.8,
                    child: Text(
                      text,
                      style: TextStyle(overflow: TextOverflow.fade),
                    ),
                  ),
                  Obx(
                    () => CheckboxListTile(
                      activeColor: AppColors.mainBg,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: contrl.agree.value,
                      onChanged: (value) {
                        contrl.agree.value = value!;
                      },
                      title: Wrap(
                        children: [
                          Text(
                            'Agree with our',
                            style: TextStyle(fontSize: 14),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.to(TermsOfUse());
                            },
                            child: Text(
                              'Terms of use',
                              style: TextStyle(
                                color: AppColors.bg,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(' and ', style: TextStyle(fontSize: 14)),
                          InkWell(
                            onTap: () {
                              Get.back();
                              Get.to(PrivacyPolicy());
                            },
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: AppColors.bg,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => MaterialButton(
                      height: 50,
                      minWidth: 300,
                      onPressed: () {
                        log('skip :${contrl.skip.value}');
                        if (contrl.agree.value == true) {
                          log('agree :${contrl.agree.value}');
                          if (contrl.skip.value == false) {
                            // log('object');
                            // Get.to(
                            //   RegisterOrSignUp(),
                            //   transition: Transition.fadeIn,
                            // );
                          } else {
                            Get.to(
                              IntroScreenDefault(),
                              transition: Transition.fadeIn,
                            );
                          }
                        }
                      },
                      color: contrl.agree.value == true
                          ? AppColors.mainBg
                          : AppColors.filled,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Agree',
                        style: TextStyle(
                          color: contrl.agree.value == true
                              ? Colors.white
                              : AppColors.grey1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String text =
      "This document is an electronic record in terms of Information Technology Act, 2000 (“IT Act, 2000”), the applicable rules there under and the provisions pertaining to electronic records in various statutes as amended by the Information Technology Act, 2000. This electronic record is generated by a computer system and does not require any physical or digital signatures.\n This document is published in accordance with the provisions of Rule 3 (1) of the Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021 that require publishing the rules and regulations, privacy policy and Terms of Use for access to or usage of www.SlrShoppee.com website.\n The domain name www.SlrShoppee.com, including the related mobile site and mobile application as well as the Seller portal (seller.SlrShoppee.com) (hereinafter referred to as “Platform”) is owned and operated by SlrShoppee Internet Private Limited (hereinafter referred to as 'SlrShoppee'), a company incorporated under the Companies Act, 1956, with its registered office at SlrShoppee Private Limited, Buildings SLR Fashion Store, Moonupeedika, Perinjanam,  680686 , Thrissur, Kerala, India\n For the purpose of the Terms of Use (hereinafter referred to as “ToU”), wherever the context so requires, ‘you’ and ‘your’ shall relate to any natural or legal person who has agreed to become a Seller on the Platform by providing registration data while registering on the Platform using computer systems. The word ‘user’ shall collectively imply a Seller, a Buyer, and any visitor on the Platform and the terms ‘we’, ‘us’ and ‘our’ shall mean SlrShoppee.\n Your use of the Platform and the features therein is governed by the following terms and conditions (ToU) including applicable policies available on the Platform, notifications and communications sent to you on the Platform which are incorporated herein by way of reference. If you transact on the Platform, you shall be subject to the policies that are applicable to the Platform for such a transaction. By mere use of the Platform you shall be contracting with SlrShoppee, and these terms and conditions including the policies constitute your binding obligations to SlrShoppee";
}
