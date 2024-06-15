import 'package:assignment/app/modules/tabbar_page/views/widgets/tabbat_title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/views/favorites_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/tabbar_page_controller.dart';
import 'widgets/myfavtab_badge_view.dart';

class TabbarPageView extends GetView<TabbarPageController> {
  TabbarPageView({super.key});
  final h = Get.lazyPut(() => HomeController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 96.h,
          title: const TabbatTitleView(),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size(1.sw, 25.h),
            child: Column(
              children: [
                Container(
                  height: 2,
                  color: AppColors.backgroung,
                ),
                SizedBox(
                  height: 52.w,
                  child: TabBar(
                      indicatorPadding: const EdgeInsets.only(top: 48).w,
                      indicatorWeight: 4.h,
                      tabs: const [
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
          ),
        ),
        body: TabBarView(
          children: [
            HomeView(),
            const FavoritesView(),
          ],
        ),
      ),
    );
  }
}
