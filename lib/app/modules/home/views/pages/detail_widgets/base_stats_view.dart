import 'package:assignment/app/modules/home/views/pages/detail_widgets/stats_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../models/pokiman_stats.dart';
import '../../../../../utils/app_utils.dart';
import '../../../controllers/home_controller.dart';

class BaseStatsView extends GetView {
  BaseStatsView({super.key, required this.stats});
  final List<dynamic> stats;
  @override
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
  return   SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == 6) {
                return StatsTileView(
                  statname: 'Average',
                  value: (AppUtils.calculateTotalBaseStat(stats) / 6).truncate(),
                  index: 1,
                );
              } else {
                PokemonStat pokimanstats = PokemonStat.fromJson(stats[index]);
                return StatsTileView(
                  statname: AppUtils
                      .capitalizeFirstLetter(pokimanstats.stat.name)
                      .replaceAll('-', ' '),
                  value: pokimanstats.baseStat,
                  index: index,
                );
              }
            },
        childCount: stats.length + 1,
      ),
    );
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16).w,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        if (index == 6) {
          return StatsTileView(
            statname: 'Average',
            value: (AppUtils.calculateTotalBaseStat(stats) / 6).truncate(),
            index: 1,
          );
        } else {
          PokemonStat pokimanstats = PokemonStat.fromJson(stats[index]);
          return StatsTileView(
            statname: AppUtils
                .capitalizeFirstLetter(pokimanstats.stat.name)
                .replaceAll('-', ' '),
            value: pokimanstats.baseStat,
            index: index,
          );
        }
      },
      itemCount: stats.length + 1,
    );
  }
}
