import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freela_fabiano/pages/home_page.dart';
import 'package:freela_fabiano/pages/splash_screen.dart';
import 'package:freela_fabiano/pages/web_view_page.dart';
import 'package:freela_fabiano/service/game_service.dart';
import 'package:freela_fabiano/service/space_shooter_service.dart';
import 'package:freela_fabiano/service/super_mario_service.dart';
import 'package:get/get.dart';

void main() {
  //Get.put(GameService());
  Get.put(SpaceShooterService());
  Get.put(SuperMarioService());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/webview', page: () => const WebViewPage()),
      ],
      home: const Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
