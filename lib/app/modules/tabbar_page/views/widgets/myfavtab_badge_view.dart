import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../data/app_colors.dart';

class MyfavtabBadgeView extends GetView {
  const MyfavtabBadgeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
                  valueListenable: Hive.box('MyFavorites').listenable(),
                  builder: (context, box, widget) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Favourites"),
                        const SizedBox(
                          width: 4,
                        ),
                        box.length == 0
                            ? const SizedBox()
                            : CircleAvatar(
                                backgroundColor: AppColors.blue,
                                radius: 10.w,
                                child: Center(
                                    child: Text(
                                  box.length.toString(),
                                  style: TextStyle(
                                      fontSize: 12.sp, color: AppColors.white),
                                )),
                              )
                      ],
                    );
                  });
  }
}
