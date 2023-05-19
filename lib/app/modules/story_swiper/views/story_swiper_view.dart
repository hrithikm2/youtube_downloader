import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/story_swiper_controller.dart';

class StorySwiperView extends GetView<StorySwiperController> {
  StorySwiperView({Key? key}) : super(key: key);
  final storySwiperController = Get.put(StorySwiperController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            // onPageChanged: (value) =>
            //     storySwiperController.onPageChanged(value),
            controller: storySwiperController.pageController,
            scrollDirection: Axis.vertical,
            children: storySwiperController.pages));
  }
}
