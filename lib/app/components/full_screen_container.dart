import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenContainer extends StatelessWidget {
  const FullScreenContainer({super.key, required this.color, this.child});
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: color,
          child: (child != null)
              ? FadeInUp(
                  child: SizedBox(
                      height: 300,
                      width: Get.width,
                      child: child ?? Container()),
                )
              : Container(),
        ),
      ),
    );
  }
}
