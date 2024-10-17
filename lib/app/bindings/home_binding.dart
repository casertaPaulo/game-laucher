import 'package:freela_fabiano/app/controller/home_controller.dart';
import 'package:freela_fabiano/app/controller/space_shooter_controller.dart';
import 'package:freela_fabiano/app/controller/super_mario_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SpaceShooterController>(() => SpaceShooterController());
    Get.lazyPut<SuperMarioController>(() => SuperMarioController());
  }
}
