import 'package:get/get.dart';

import '../controllers/story_swiper_controller.dart';

class StorySwiperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorySwiperController>(
      () => StorySwiperController(),
    );
  }
}
