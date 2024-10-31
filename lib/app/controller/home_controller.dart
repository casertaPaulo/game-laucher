import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isMarioSelected = false.obs;
  @override
  void onInit() async {
    // Define orientação fixada na horizontal ao entrar na página
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    print("FECHANDO O STATE");
    super.onClose();
  }
}
