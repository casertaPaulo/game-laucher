import 'package:flutter/material.dart';
import 'package:freela_fabiano/app/controller/space_shooter_controller.dart';
import 'package:freela_fabiano/app/controller/super_mario_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  RxBool isMarioSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Get.find<SpaceShooterController>().isAppInstalled();
      Get.find<SuperMarioController>().isAppInstalled();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
