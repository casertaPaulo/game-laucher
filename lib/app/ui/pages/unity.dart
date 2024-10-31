// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:game_laucher/util/util.dart';
import 'package:get/get.dart';

class Unity extends StatefulWidget {
  final String scene;
  const Unity({super.key, required this.scene});

  @override
  // ignore: library_private_types_in_public_api
  _UnityState createState() => _UnityState();
}

class _UnityState extends State<Unity> {
  var state = Get.find<UnityController>();
  var isLoading = true.obs;

  void onUnityCreated(UnityWidgetController controller) {
    // Armazena o controlador Unity na instância de UnityController
    state.unityWidgetController = controller;

    controller.postMessage(
      'SceneControl',
      'LoadScene',
      widget.scene,
    );

    // Define a cena para carregar após o Unity estar completamente carregado
    controller.isLoaded()?.then((loaded) {
      if (loaded!) {
        state.isUnityLoaded.value = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  @override
  void dispose() {
    //Seta a orientação na horizontal.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UnityWidget(
            runImmediately: true,
            fullscreen: false,
            onUnityCreated: (controller) {
              state.unityWidgetController = controller;
              print("INICIANDO O CONTROLADOR NO STATE");
              controller.postMessage(
                'SceneControl',
                'LoadScene',
                widget.scene,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  heroTag: 'bt2',
                  backgroundColor: Colors.white,
                  child: const Center(
                    child: Icon(
                      Icons.home,
                      size: 35,
                    ),
                  ),
                  onPressed: () {
                    Get.offNamed('/home');
                  },
                )),
          ),
          // Carrega a tela por 5 segundos
          Obx(() {
            return isLoading.value
                ? Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/background-space.png'),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Degradê para suavizar a transição para a cor de fundo
                      Container(
                          decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xFF12284d), // Cor de fundo para combinar
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          stops: [0.2, 0.8], // Define onde o degradê começa
                        ),
                      )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/images/ship-normal2.png',
                          height: Util.height(context) * .8,
                        ),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                            onComplete: (controller) => controller.dispose(),
                          )
                          .then()
                          .moveY(
                            begin: -20,
                            end: 15,
                            curve: Curves.easeInOut,
                            duration: 1000.ms,
                          )
                          .then()
                          .moveY(
                            begin: 15,
                            end: -20,
                            curve: Curves.easeInOut,
                          ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(50.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox();
          })
        ],
      ),
    );
  }
}
