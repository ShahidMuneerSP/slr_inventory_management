
import 'package:get/get.dart';

class Introcontroller extends GetxController {
  RxBool agree = false.obs;
  RxBool loading = true.obs;
  RxBool skip = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      loading.value = false;
    });
  }
}