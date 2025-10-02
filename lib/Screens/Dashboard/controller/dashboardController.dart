// ignore_for_file: file_names, strict_top_level_inference, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slr_inventory_management/Screens/Dashboard/model/profile_model.dart';
import 'package:slr_inventory_management/Utils/Api%20Contants/api_constants.dart';

class Dashboardcontroller extends GetxController {
  final scrollController = ScrollController();
  var loading = false.obs;
  var data;
  Rx<Map<String, dynamic>> raw = (Rx<Map<String, dynamic>>({}));
  var oNCloses = true.obs;
  Future<Profile> fetchData() async {
    loading(true);
    // String token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpZCI6IjIiLCJ1c2VybmFtZSI6IktpcmFuS3VtYXJAMTIzIiwidHlwZSI6InRoaXJkcGFydHkiLCJuYW1lIjoiS0lSQU4gS3VtYXIifQ.MEUCIHSclrkeVYEHU7GZByQBZKTibz2pMZxOoKi6s3TPkcI1AiEA66xtIM1uC6Dpu25qX49tvw47hfPrLgiizI6FRGwBoyU';
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token')!;
    var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
    try {
      var r;
      final response = await http.get(
        Uri.parse(ApiConstants.profile_url),
        headers: headers,
      );
      log("response.statusCode: ${response.statusCode}");

      log(response.body);
      if (response.statusCode == 200) {
        loading(false);
        data = Profile.fromJson(jsonDecode(response.body));
        r = jsonDecode(response.body);
        raw.value = r['rawViewData'];
        if (raw.value['status'] == 'Close') {
          oNCloses(false);
        } else {
          oNCloses(true);
        }

        /// print('datas'+raw.toString());
      } else {
        // loading(false);
      }
    } catch (error) {
      // loading(false);
      log("Error :$error");
    }
    return data!;
  }
}
