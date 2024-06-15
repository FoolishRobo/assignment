import 'package:assignment/app/data/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class TabbatTitleView extends GetView {
  const TabbatTitleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 24.h,
          width: 25.w,
          child: Image.asset(
          AppImages.ball,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          'Pokedex',
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}
