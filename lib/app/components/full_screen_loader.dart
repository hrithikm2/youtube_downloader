// 🐦 Flutter imports:
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

// 🌎 Project imports:

class FullScreenLoader extends StatelessWidget {
  final bool isVisible;
  final String? loadingText;
  final double blur;
  final bool tryAgain;

  final void Function()? onpressed;
  const FullScreenLoader(
      {Key? key,
      required this.isVisible,
      this.loadingText,
      this.blur = 0,
      this.tryAgain = false,
      this.onpressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var H = Get.height;
    var W = Get.width;
    return Visibility(
      visible: isVisible,
      child: FadeIn(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            height: H,
            width: W,
            color: Colors.white.withOpacity(0.75),
            child: Center(
                child: tryAgain
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Authentication  Unsuccessfull".text.lg.make(),
                          TextButton(
                            onPressed: onpressed ?? () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Try Again".text.bold.make(),
                                5.widthBox,
                                const Icon(
                                  Icons.refresh,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                  height: 50,
                                  child: Image.asset(
                                    'assets/logo.png',
                                  )),
                              10.heightBox,
                              Text(
                                loadingText ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
