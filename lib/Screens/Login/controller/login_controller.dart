// ignore_for_file: strict_top_level_inference, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slr_inventory_management/Screens/Dashboard/view/dashboard_view.dart';
import 'package:slr_inventory_management/Utils/Api%20Contants/api_constants.dart';
import 'package:slr_inventory_management/Utils/colors/colors.dart';
// import 'package:slr/controller/form_controller.dart';
// import 'package:slr/utils/api_const.dart';
// import 'package:slr/utils/color.dart';
// import 'package:slr/view/home/mainpage.dart';

class LoginController extends GetxController {
  var isPending = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  // final form = Get.put(FormController());
  var isLoading = false.obs;

  String ipa = '';
  Future ip() async {
    final response = await http.get(Uri.parse('https://api.ipify.org/'));
    log(response.statusCode.toString());
    log(response.body);
  }

  isLogged() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('islogged', false);
    log(pref.get('islogged').toString());
  }

  loginPost({
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    String token = '';
    final SharedPreferences pref = await SharedPreferences.getInstance();

    isLoading(true);
    try {
      final url = Uri.parse(ApiConstants.login_post);
      log(url.toString());
      final response = await http.post(
        Uri.parse(ApiConstants.login_post),
        body: {'username': email, 'password': pass},
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        isLoading(false);

        var data = jsonDecode(response.body);
        if (data["SESSION"]["authToken"] != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DashboardScreen();
              },
            ),
            (r) {
              return false;
            },
          );
          pref.setString('token', data["SESSION"]["authToken"]);
          token = pref.getString('token')!;
          log('Token : $token');

          isPending.value = false;
          isLogged();
          this.email.clear();
          this.pass.clear();
          successSnackBar(
            title: 'Login Success',
            text: 'Welcome ${data["SESSION"]['name'].toString()}',
          );
        }
      } else {
        isLoading(false);
        var err = jsonDecode(response.body);
        errorSnackBar(
          title: 'Login Failed',
          text: err['RESPONSE']['message'].toString(),
        );
      }
    } catch (e) {
      log(e.toString());
      isLoading(false);
      errorSnackBar(
        title: 'Login Failed',
        text: 'Something went a wrong please retry',
      );

    
    }
  }

  errorSnackBar({required String title, required String text}) {
    Get.showSnackbar(
      GetSnackBar(
        animationDuration: Duration(seconds: 2),
        duration: Duration(seconds: 4),
        title: title,
        dismissDirection: DismissDirection.horizontal,
        messageText: Text(text, style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        icon: Container(
          width: 50,
          height: 35,
          decoration: BoxDecoration(
      
          ),
          child: Center(
            child: Icon(
              Icons.info,
              size: 35,
              color: AppColors.dangerOverlayColor,
            ),
          ),
        ),
        borderColor: Colors.black,
        backgroundColor: Colors.black,
        borderRadius: 5,
        onTap: (snack) {},
      ),
    );
  }

  successSnackBar({required String title, required String text}) {
    Get.showSnackbar(
      GetSnackBar(
        animationDuration: Duration(seconds: 2),
        duration: Duration(seconds: 5),
        title: title,
        dismissDirection: DismissDirection.horizontal,
        messageText: Text(text, style: TextStyle(color: Colors.white)),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        icon: Container(
          width: 20,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/Images/slr_logo.png'),
              // fit: BoxFit.cover,
            ),
          ),
        ),
        borderColor: Colors.black,
        backgroundColor: Colors.black,
        borderRadius: 5,
        onTap: (snack) {},
      ),
    );
  }
}
