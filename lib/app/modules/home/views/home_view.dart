import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return GestureDetector(
      onTap: controller.reset,
      child: Scaffold(
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
        body: Obx(
          () => Stack(
            children: [
              Padding(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                          ),
                          20.heightBox,
                          // GetX<HomeController>(
                          //builder: (controller) =>
                        ])),
              ),
              Visibility(
                  visible: controller.isLoading.value,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: MaterialButton(
                height: kBottomNavigationBarHeight * 1.2,
                shape: const Border(right: BorderSide(color: Colors.black)),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Download Audio Only"
                        .text
                        //.white
                        .medium
                        .make(),
                    const Icon(
                      Icons.music_note,
                      //  color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                height: kBottomNavigationBarHeight * 1.2,
                //shape: RoundedRectangleBorder(
                //  borderRadius: BorderRadius.circular(10)),
                color: Theme.of(context).primaryColor,
                onPressed: () => controller.downloadVideo(),
                //controller.onDownloadVideoTapped,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Download Video"
                        .text
                        //white
                        .medium
                        .make(),
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
    );
  }
}
