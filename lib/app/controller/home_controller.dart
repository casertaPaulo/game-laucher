import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  RxBool isMarioSelected = false.obs;
  @override
  void onInit() {
    // Define orientação fixada na horizontal ao entrar na página
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.onInit();
  }
}
