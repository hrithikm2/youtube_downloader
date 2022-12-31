import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  TextEditingController urlController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  late FocusNode node;
  void increment() => count.value++;
  late Video streamInfo;

  @override
  void onInit() {
    node = FocusNode();
    super.onInit();
  }

  String? checkValidUrl(String? value) {
    if (value != null && value.isNotEmpty && value.contains('/')) {
      return null;
    } else {
      return "Enter a valid URL";
    }
  }

  Future<void> downloadVideo() async {
    if (formKey.currentState?.validate() == true) {
      var yt = YoutubeExplode();
      streamInfo = await yt.videos.get(urlController.text);

      print(streamInfo.id);

      // Close the YoutubeExplode's http client.
      yt.close();
    }
  }

  void reset() {
    node.unfocus();
  }
}
