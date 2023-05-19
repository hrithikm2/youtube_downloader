import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/full_screen_container.dart';

class StorySwiperController extends GetxController {
  late PageController pageController;

  RxList<Widget> pages = <Widget>[
    const FullScreenContainer(color: Colors.red),
    const FullScreenContainer(color: Colors.blue),
    const FullScreenContainer(color: Colors.orange),
    const FullScreenContainer(color: Colors.pink),
    const FullScreenContainer(color: Colors.green),
    const FullScreenContainer(color: Colors.white),
    const FullScreenContainer(color: Colors.black),
    const FullScreenContainer(color: Colors.pink),
    const FullScreenContainer(color: Colors.green),
    const FullScreenContainer(color: Colors.white),
    FullScreenContainer(
      color: Colors.black,
      child: ExtendedImage.network(
        "https://images.unsplash.com/photo-1673470907080-bbabe4fc2a66?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
        fit: BoxFit.fitWidth,
      ),
    ),
  ].obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {});
    super.onInit();
  }

  @override
  void onReady() {
    animate();
    super.onReady();
  }

  @override
  void onClose() {
    pageController.removeListener(() {});
    super.onClose();
  }

  Future<void> animate() async {
    for (int i = 0; i < pages.length; i++) {
      if (i < 3) {
        await Future.delayed(const Duration(milliseconds: 500)).then((value) {
          pageController.animateToPage(i,
              duration: kThemeAnimationDuration, curve: Curves.linear);
        });
      } else if (i <= 6 && i >= 3) {
        await Future.delayed(const Duration(milliseconds: 200)).then((value) {
          pageController.animateToPage(i,
              duration: kThemeAnimationDuration, curve: Curves.linear);
        });
      }
      // else if (i >= 17) {
      //   pageController.jumpToPage(0);
      //   i = 0;
      // }
      else {
        await Future.delayed(const Duration(milliseconds: 50)).then((value) {
          pageController.animateToPage(i,
              duration: kThemeAnimationDuration, curve: Curves.linear);
        });
      }
      log(i.toString());
    }
  }
  // void onPageChanged(int value) {
  //   pageController.jumpTo(value.toDouble());
  //}
}
