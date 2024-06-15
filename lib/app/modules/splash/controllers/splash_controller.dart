
import 'dart:async';

import 'package:get/get.dart';

import '../../internetcheck/views/internetcheck_view.dart';

class SplashController extends GetxController {

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 3))
        .then((v) => Get.offAll(() => const InternetcheckView(),transition: Transition.fade,duration: const Duration(seconds: 1)));
  }



  void increment() => count.value++;
}
