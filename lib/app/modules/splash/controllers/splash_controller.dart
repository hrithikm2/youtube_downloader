import 'package:get/get.dart';
import 'package:youtube_downloader/app/modules/home/views/home_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    redirect();

    super.onInit();
  }

  void increment() => count.value++;

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.off(const HomeView()));
  }
}
