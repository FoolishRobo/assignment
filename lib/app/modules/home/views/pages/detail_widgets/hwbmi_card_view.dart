import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'h_w_bmi_view.dart';

class HwbmiCardView extends GetView {
  const HwbmiCardView({super.key, required this.height, required this.weight,required this.bmi});
  final String height;
  final String weight;
  final String bmi;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78.w,
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16).w,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HWBmiView(
            title: 'Height',
            value: height,
          ),
          SizedBox(
            width: 48.w,
          ),
          HWBmiView(
            title: 'Weight',
            value: weight,
          ),
          SizedBox(
            width: 48.w,
          ),
          HWBmiView(
            title: 'BMI',
            value: bmi,
          ),
        ],
      ),
    );
  }
}
