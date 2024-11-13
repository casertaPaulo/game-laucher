import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:game_laucher/app/routes/app_routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  Get.put(UnityController(), permanent: true);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
