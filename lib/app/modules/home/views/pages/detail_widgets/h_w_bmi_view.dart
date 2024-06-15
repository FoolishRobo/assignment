import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class HWBmiView extends GetView {
  const HWBmiView({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.h,
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        Text(value, style: Theme.of(context).textTheme.bodySmall)
      ],
    );
  }
}
