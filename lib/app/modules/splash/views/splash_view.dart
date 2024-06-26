import 'package:assignment/app/data/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
 const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 75.h,
            width: 75.w,
            child: Image.asset(
              AppImages.ball,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pokemon'.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Pokedex',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
