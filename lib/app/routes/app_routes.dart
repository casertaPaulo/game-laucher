import 'package:freela_fabiano/app/bindings/home_binding.dart';
import 'package:freela_fabiano/app/ui/pages/home_page.dart';
import 'package:freela_fabiano/app/ui/pages/splash_page.dart';
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
    )
  ];
}
