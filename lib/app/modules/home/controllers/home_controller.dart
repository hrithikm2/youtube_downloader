import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  TextEditingController urlController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  late FocusNode node;
  void increment() => count.value++;
  final isLoading = false.obs;
  late Video streamInfo;
  File? file;
  late YoutubeExplode yt;
  Directory? directory;
  List? availableVideoQualities;

  @override
  void onInit() {
    node = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    yt.close();
    super.onClose();
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
      isLoading.toggle();
      yt = YoutubeExplode();
      streamInfo = await yt.videos.get(urlController.text);

      log(streamInfo.id.toString());
      var manifest = await yt.videos.streamsClient.getManifest(streamInfo.id);
      var streamData = manifest.muxed.bestQuality;
      print(streamData);

      var stream = yt.videos.streamsClient.get(streamData);
      String filePath = await getDownloadPath();
      directory = Directory(filePath);
      file = File("$filePath/${streamInfo.title}.mp4");
      print("print : $file");

      if (await directory!.exists()) {
        print("directory exiss");
      } else {
        print("create karo");
        directory!.create();
      }
// Open a file for writing.
      // https://www.youtube.com/watch?v=Oxr9XWogBQA

      IOSink? fileStream = file?.openWrite();

// Pipe all the content of the stream into the file.
      await stream.pipe(fileStream!);

// Close the file.
      await fileStream.flush();
      await fileStream.close();
      isLoading.toggle();
    }
  }

  void reset() {
    node.unfocus();
  }

  //ANDROID ONLY
  Future<String> getDownloadPath() async {
    directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/$folder";
      } else {
        break;
      }
    }
    newPath = "$newPath/Download/YouTubeDownloader";
    return newPath;
  }
}
