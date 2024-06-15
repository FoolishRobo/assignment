import 'package:assignment/app/data/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/app_colors.dart';
import '../../../models/pokiman_stats.dart';
import '../controllers/home_controller.dart';
import '../pokeman_detail_model.dart';
import 'add_remove_favorites_view.dart';
import 'base_stats_view.dart';
import 'h_w_bmi_view.dart';

class DetailsviewView extends GetView {
  DetailsviewView({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    PokemanDetais pokidetails = Get.arguments[0];
    var stats = pokidetails.base_stats;

    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: AppColors.unselectedlable,
          backgroundColor: Get.arguments[1],
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                                top: 23.0, left: 16, bottom: 14)
                            .w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                  .capitalizeFirstLetter(pokidetails.name),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Row(
                              children:
                                  List.generate(pokidetails.types.length, (v) {
                                PokemonType pokimantype =
                                    PokemonType.fromJson(pokidetails.types[v]);
                                return Text(
                                  controller.capitalizeFirstLetter(
                                          pokimantype.type.name) +
                                      "${v == 0 && pokidetails.types.length > 1 ? "," : ""}" +
                                      ' ',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                );
                              }),
                            ),
                            Spacer(),
                            Text(
                              '#' + Get.arguments[2],
                              style: Theme.of(context).textTheme.displayMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -16.w,
                      right: -52.w,
                      child: Image.asset(
                        controller
                            .getbgImage(pokidetails.types[0]['type']['name']),
                        height: 176.h,
                        width: 176.w,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 16.w,
                      child: Image.network(
                        pokidetails.image,
                        height: 125.h,
                        width: 136.w,
                      ),
                    )
                  ],
                ),
                color: Get.arguments[1],
              ),
              Container(
                height: 78,
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16).w,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HWBmiView(
                      title: 'Height',
                      value: pokidetails.height.toString(),
                    ),
                    SizedBox(
                      width: 48.w,
                    ),
                    HWBmiView(
                      title: 'Weight',
                      value: pokidetails.weight.toString(),
                    ),
                    SizedBox(
                      width: 48.w,
                    ),
                    HWBmiView(
                      title: 'BMI',
                      value: controller
                          .calculatebmi(pokidetails.height.toDouble(),
                              pokidetails.weight.toDouble())
                          .toStringAsFixed(1),
                    ),
                  ],
                ),
              ),
              Container(
                height: 8.h,
                width: double.infinity,
                color: AppColors.backgroung,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0).w,
                child: Text(
                  "Base Stats",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Divider(),
              BaseStatsView(
                stats: stats,
              )
            ],
          ),
        ),
        floatingActionButton: AddRemoveFavoritesView(
          pokidetails: pokidetails,
        ));
  }
}
