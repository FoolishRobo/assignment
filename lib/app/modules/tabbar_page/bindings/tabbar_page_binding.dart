import 'package:get/get.dart';

import '../controllers/tabbar_page_controller.dart';

class TabbarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabbarPageController>(
      () => TabbarPageController(),
    );
  }
}
