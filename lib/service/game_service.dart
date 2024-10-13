// ignore_for_file: avoid_print

import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GameService extends GetxService {
  RxBool isGameInstalled = false.obs;
  RxBool isInstalling = false.obs;

  Future<bool> hasPermission() async {
    var status = await Permission.requestInstallPackages.request();

    return status.isGranted;
  }

  Future<void> isAppInstalled() async {
    isGameInstalled.value =
        await DeviceApps.isAppInstalled('com.company.spaceshooter');
    print("STATUS: $isGameInstalled.");
  }

  void launchGame() async {
    bool isInstalled =
        await DeviceApps.isAppInstalled('com.company.spaceshooter');

    if (isInstalled) {
      DeviceApps.openApp('com.company.spaceshooter');
    } else {
      print("Não instalado, abrindo instalador!");
      isInstalling.value = true;

      // Verifica a permissão
      if (await hasPermission()) {
        Directory tempDir = await getTemporaryDirectory();
        String apkPath = '${tempDir.path}/SpaceShooter.apk';

        try {
          ByteData data = await rootBundle.load('assets/game/SpaceShooter.apk');
          List<int> bytes = data.buffer.asUint8List();
          File apkFile = File(apkPath);
          await apkFile.writeAsBytes(bytes);

          OpenFile.open(apkPath);
        } catch (e) {
          print('Erro ao carregar o APK: $e');
        }
      } else {
        print("Permissão para instalar pacotes não foi concedida.");
      }
    }
  }
}
