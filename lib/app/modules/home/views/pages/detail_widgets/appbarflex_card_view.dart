import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../utils/app_utils.dart';

class AppbarflexCardView extends GetView {
  const AppbarflexCardView({super.key,required this.name,required this.types,required this.id,required this.bgimage,required this.image});
  final String name;
  final String bgimage;
  final String image;
  final List types;
  final int id;
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(collapseMode: CollapseMode.parallax,
      background: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 48).w,
          height: 200.h,
          width: double.infinity,
          color: Get.arguments[1],
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 23.0, left: 16, bottom: 14)
                      .w
                      .w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppUtils.capitalizeFirstLetter(
                           name),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge,
                      ),
                      Row(
                          children: AppUtils.generateTypeTextList(
                              context, types)),
                      const Spacer(),
                      Text(
                        '#${AppUtils.formatNumberWithLeadingZeros(
                               id, 3)}',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -16.w,
                right: -52.w,
                child: Image.asset(
                  AppUtils.getbgImage(
                      bgimage),
                  height: 176.h,
                  width: 176.w,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 16.w,
                child: Image.network(
                image,
                  height: 125.h,
                  width: 136.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
