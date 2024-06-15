import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../data/app_colors.dart';

class StatsTileView extends GetView {
  const StatsTileView({super.key,required this.statname,required this.value,required this.index});
  final String statname;
  final int value;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0,right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                statname,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                width: 8.sp,
              ),
              Text(
                value.toString(),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          LinearProgressIndicator(
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(30).w,
            value: value / 100,
            color: index < 3 || index == 5
                ? AppColors.pi_pink
                : AppColors.pi_yellow,
          ),
          SizedBox(
            height: 24.h,
          ),
        ],
      ),
    );
  }
}
