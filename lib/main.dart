import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freela_fabiano/pages/home_page.dart';
import 'package:freela_fabiano/pages/splash_screen.dart';
import 'package:freela_fabiano/pages/web_view_page.dart';
<<<<<<< HEAD
import 'package:freela_fabiano/service/space_shooter_service.dart';
import 'package:freela_fabiano/service/super_mario_service.dart';
=======
>>>>>>> a716d2531d37f79a910d4238d86a056babbcc9e0
import 'package:get/get.dart';

void main() {
  //Get.put(GameService());
  //Get.put(SpaceShooterService());
  //Get.put(SuperMarioService());
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
