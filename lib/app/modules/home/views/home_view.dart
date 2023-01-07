import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../components/full_screen_loader.dart';
import '../controllers/hello.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => GestureDetector(
          onTap: controller.reset,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/logo.png",
                    ),
                  ),
                  title: const Text('YouTube Downloader'),
                  centerTitle: false,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Enter Video URL".text.make(),
                            20.heightBox,
                            TextFormField(
                              focusNode: controller.node,
                              validator: (val) => controller.checkValidUrl(val),
                              controller: controller.urlController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                            ),
                            20.heightBox,
                            // GetX<HomeController>(
                            //builder: (controller) =>
                          ])),
                ),
                bottomNavigationBar: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: kBottomNavigationBarHeight,
                        shape: const Border(
                            right: BorderSide(color: Colors.black)),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Get.to(() => const Profile());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: "Download Audio Only"
                                  .text
                                  .align(TextAlign.center)
                                  //.white
                                  .medium
                                  .make(),
                            ),
                            const Icon(
                              Icons.music_note,
                              //  color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        height: kBottomNavigationBarHeight,
                        //shape: RoundedRectangleBorder(
                        //  borderRadius: BorderRadius.circular(10)),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => controller.downloadVideo(),
                        //controller.onDownloadVideoTapped,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width / 3,
                              child: "Download Video"
                                  .text
                                  //white
                                  .medium
                                  .make(),
                            ),
                            const Icon(
                              Icons.video_collection,
                              // color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FullScreenLoader(
                isVisible: controller.isLoading.value,
                loadingText: "Loading...",
              ),
            ],
          )),
    );
  }
}
