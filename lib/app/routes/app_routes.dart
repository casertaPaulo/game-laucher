import 'package:game_laucher/app/bindings/home_binding.dart';
import 'package:game_laucher/app/ui/pages/home_page.dart';
import 'package:game_laucher/app/ui/pages/splash_page.dart';
import 'package:game_laucher/app/ui/pages/unity.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const initial = '/';

  static final routes = [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

  ];
}
