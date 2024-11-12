import 'package:flutter/material.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isMarioSelected = false.obs;
  UnityController unity = Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      unity.changeScene("EmptyScene");
    });
  }
}
