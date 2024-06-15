import 'package:assignment/app/data/app_images.dart';
import 'package:assignment/app/modules/tabbar_page/views/tabbar_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/internetcheck_controller.dart';

class InternetcheckView extends GetView<InternetcheckController> {
  const InternetcheckView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InternetcheckController());
    return Obx(() => controller.connectionType == MConnectivityResult.wifi ||
            controller.connectionType == MConnectivityResult.mobile
        ? TabbarPageView()
        : const InternetcheckErrorView());
  }
}

class InternetcheckErrorView extends GetView<InternetcheckController> {
  const InternetcheckErrorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.error,
              height: 200.h,
              width: 200.w,
            ),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text("No Internet!"),
            )
          ],
        ),
      ),
    );
  }
}
