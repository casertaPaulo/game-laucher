// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class GameController extends GetxController {
  RxBool isGameInstalled = false.obs;
  RxBool isInstalling = false.obs;

  Future<bool> hasPermission() async {
    var status = await Permission.requestInstallPackages.request();

    return status.isGranted;
  }

  Future<void> isAppInstalled();

  void launchGame();
}
