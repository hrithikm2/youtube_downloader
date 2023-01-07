import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

enum LoadingState { gettingInfo, downloading, savingVideo }

class HomeController extends GetxController {
  //TODO: Implement HomeController

  ///Text Editing controller for URL Textfield
  TextEditingController urlController = TextEditingController();

  ///Form Key
  GlobalKey<FormState> formKey = GlobalKey();

  ///Focus Node to unfocus textfield
  late FocusNode node;

  ///Loading state value
  final isLoading = false.obs;

  ///Stream information extracted from URL
  late Video streamInfo;

  ///File where video stream will be stored
  File? file;

  /// Youtube Explode plugin instance
  late YoutubeExplode yt;

  ///Directory where the video will be saved
  Directory? directory;

  /// List of all available qualities of a video
  List? availableVideoQualities;

  ///The text to be shown while loading
  RxString loadingText = "Loading...".obs;

  ///Stream Manifest that will hold stream data
  StreamManifest? manifest;

  ///METHODS

  @override
  void onInit() {
    node = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    yt.close();
    node.dispose();
    super.onClose();
  }

  ///Validator for URL Textfield
  String? checkValidUrl(String? value) {
    if (value != null && value.isNotEmpty && value.contains('/')) {
      return null;
    } else {
      return "Enter a valid URL";
    }
  }

  ///Method to get video information from URL
  Future<void> getVideoInfo() async {
    if (formKey.currentState?.validate() == true) {}
  }

  ///THIS METHOD WILL HANDLE ALL TASKS THAT WILL TAKE PLACE TO DOWNLOAD VIDEO
  Future<void> downloadVideo() async {
    if (formKey.currentState?.validate() == true &&
        await Permission.storage.request().isGranted) {
      isLoading.toggle();
      yt = YoutubeExplode();
      streamInfo = await yt.videos.get(urlController.text);
      log(streamInfo.id.toString());
      var manifest = await yt.videos.streamsClient.getManifest(streamInfo.id);
      var streamData = manifest.muxed.bestQuality;
      log(streamData.toString());

      var stream = yt.videos.streamsClient.get(streamData);
      String filePath = await getDownloadPath();
      directory = Directory(filePath);
      file = File(
          "$filePath/${streamInfo.title.replaceAll(RegExp(r'[ \W]'), '_')}.mp4");
      print("print : $file");

      if (await directory!.exists()) {
        print("directory exiss");
      } else {
        print("create karo");
        directory!.create();
      }

      IOSink? fileStream = file?.openWrite();

// Pipe all the content of the stream into the file.
      if (fileStream != null) {
        await stream.pipe(fileStream);
      }

// Close the file.
      await fileStream?.flush();
      await fileStream?.close();
      isLoading.toggle();
    }
  }

  void reset() {
    node.unfocus();
  }

  ///ANDROID ONLY
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
