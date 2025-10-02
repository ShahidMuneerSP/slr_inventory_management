// ignore_for_file: void_checks, strict_top_level_inference, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Intro/widgets/purchaseLoadingWidget.dart';
import 'package:slr_inventory_management/Screens/Login/controller/login_controller.dart';
import 'package:slr_inventory_management/Screens/Login/widgets/roundContainer.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  // final form = Get.put(FormController());
  final loginController = Get.put(LoginController());
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: !loginController.isPending.value,
        onPopInvoked: (didPop) {
          if (didPop == true) {}
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    colors: [Colors.black12, Colors.white12],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 1.4,
              right: MediaQuery.of(context).size.width / 2.5,
              child: RoundContainer(
                color: AppColors.mainBg,
                width: 350,
                height: 350,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 1.5,
              left: MediaQuery.of(context).size.width / 3.1,
              child: RoundContainer(
                color: Colors.black26,
                width: 350,
                height: 350,
              ),
            ),

            Center(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Form(
                  key: _globalKey,
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/Images/slr_logo.png', height: 80),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        AutofillGroup(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                ),
                                child: SizedBox(
                                  height: 70,
                                  child: TextFormField(
                                    autofillHints: [AutofillHints.username],
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    controller: loginController.email,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Username",
                                      filled: true,
                                      fillColor: AppColors.filled,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Username';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                ),
                                child: SizedBox(
                                  height: 70,
                                  child: TextFormField(
                                    autofillHints: [AutofillHints.password],
                                    controller: loginController.pass,
                                    textInputAction: TextInputAction.done,
                                    obscureText: visibility ? true : false,
                                    cursorColor: Colors.black,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: visibility
                                            ? Icon(
                                                Icons.visibility,
                                                color: AppColors.grey1,
                                              )
                                            : Icon(
                                                Icons.visibility_off,
                                                color: Colors.black,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            if (visibility) {
                                              visibility = false;
                                            } else {
                                              visibility = true;
                                            }
                                          });
                                        },
                                      ),
                                      hintText: "Password",
                                      filled: true,
                                      fillColor: AppColors.filled,

                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Strong Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 60),

                        SizedBox(
                          width: 300,
                          height: 55,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                AppColors.mainBg,
                              ),
                            ),
                            onPressed: () {
                              String email = loginController.email.text.trim();
                              String password = loginController.pass.text
                                  .trim();
                              if (_globalKey.currentState!.validate()) {
                                if (loginController.email.text != '' ||
                                    loginController.pass.text != '') {
                                  loginController.loginPost(
                                    email: email,
                                    pass: password,
                                    context: context,
                                  );
                                } else {
                                  return _checkFieldSnack();
                                }
                              }
                            },
                            child: Obx(
                              () => loginController.isLoading.value == true
                                  ? PurchaseLoadingWidget()
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkFieldSnack() {}
}
