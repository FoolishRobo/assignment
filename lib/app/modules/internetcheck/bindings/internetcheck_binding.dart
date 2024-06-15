import 'package:get/get.dart';

import '../controllers/internetcheck_controller.dart';

class InternetcheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetcheckController>(
      () => InternetcheckController(),
    );
  }
}
