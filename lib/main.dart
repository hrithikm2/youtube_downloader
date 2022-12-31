import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/splash/bindings/splash_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(primaryColor: const Color(0xffEA3323)).copyWith(
          appBarTheme:
              const AppBarTheme(elevation: 0, color: Color(0xff010101))),
      initialBinding: SplashBinding(),
    ),
  );
}
