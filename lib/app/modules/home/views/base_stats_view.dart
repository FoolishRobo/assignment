import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../models/pokiman_stats.dart';
import '../controllers/home_controller.dart';

class BaseStatsView extends GetView {
  BaseStatsView({Key? key, required this.stats}) : super(key: key);
  final List<dynamic> stats;
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16).w,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        if (index == 6) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    "Average",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(
                    width: 8.sp,
                  ),
                  Text(
                    '${(controller.calculateTotalBaseStat(stats) / 6).truncate()}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              LinearProgressIndicator(
                minHeight: 4.h,
                borderRadius: BorderRadius.circular(30).w,
                value: (controller.calculateTotalBaseStat(stats) / 6) / 100,
                color: AppColors.pi_pink,
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          );
        } else {
          PokemonStat pokimanstats = PokemonStat.fromJson(stats[index]);
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    controller
                        .capitalizeFirstLetter(pokimanstats.stat.name)
                        .replaceAll('-', ' '),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(
                    width: 8.sp,
                  ),
                  Text(
                    pokimanstats.baseStat.toString(),
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
                value: pokimanstats.baseStat / 100,
                color: index < 3 || index == 5
                    ? AppColors.pi_pink
                    : AppColors.pi_yellow,
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          );
        }
      },
      itemCount: stats.length + 1,
    );
  }
}
