import 'package:assignment/app/modules/tabbar_page/views/tabbat_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/app_colors.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/favorites_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/tabbar_page_controller.dart';
import 'myfavtab_badge_view.dart';

class TabbarPageView extends GetView<TabbarPageController> {
  TabbarPageView({Key? key}) : super(key: key);
  final h = Get.lazyPut(() => HomeController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 96.h,
          title: TabbatTitleView(),
          centerTitle: true,
          bottom: PreferredSize(
            child: Column(
              children: [
                Container(
                  height: 2,
                  color: AppColors.backgroung,
                ),
                Container(
                  height: 52.w,
                  child: TabBar(
                      indicatorPadding: EdgeInsets.only(top: 48).w,
                      indicatorWeight: 4.h,
                      tabs: [
                        Tab(
                          text: "All Pokemons",
                        ),
                        Tab(
                          child: MyfavtabBadgeView(),
                        )
                      ]),
                ),
              ],
            ),
            preferredSize: Size(1.sw, 25.h),
          ),
        ),
        body: TabBarView(
          children: [
            HomeView(),
            FavoritesView(),
          ],
        ),
      ),
    );
  }
}
