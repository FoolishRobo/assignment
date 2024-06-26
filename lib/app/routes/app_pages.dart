import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/internetcheck/bindings/internetcheck_binding.dart';
import '../modules/internetcheck/views/internetcheck_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tabbar_page/bindings/tabbar_page_binding.dart';
import '../modules/tabbar_page/views/tabbar_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.TABBAR_PAGE,
      page: () => TabbarPageView(),
      binding: TabbarPageBinding(),
    ),
    GetPage(
      name: _Paths.INTERNETCHECK,
      page: () => const InternetcheckView(),
      binding: InternetcheckBinding(),
    ),
  ];
}
