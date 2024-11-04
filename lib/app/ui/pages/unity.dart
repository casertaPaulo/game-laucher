import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/util/util.dart';
import 'package:get/get.dart';

class Unity extends StatefulWidget {
  const Unity({super.key});

  @override
  State<Unity> createState() => _UnityState();
}

class _UnityState extends State<Unity> {
  UnityWidgetController? unityWidgetController;
  var isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var idPage = Get.parameters['id'];
    return Scaffold(
      body: Stack(
        children: [
          UnityWidget(
            onUnityCreated: (controller) {
              onUnityCreated(controller, idPage!);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: FloatingActionButton(
                onPressed: () {
                  Get.toNamed('/home');
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.home),
              ),
            ),
          ),
          Obx(() {
            if (isLoading.value) {
              return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background-space.png'),
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
              );
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }

  // Callback para atribuar o controllador da Unity Widget.
  void onUnityCreated(UnityWidgetController controller, String scene) {
    unityWidgetController = controller;
    changeScene(scene);
  }

  // Aciona o método de troca de cena da Unity.
  void changeScene(String scene) async {
    unityWidgetController?.postMessage(
      'SceneControl',
      'LoadScene',
      scene,
    );
  }
}




// Stack(
//         children: [
//           UnityWidget(
//             uiLevel: 0,
//             fullscreen: false,
//             onUnityCreated: (controller) {
//               state.unityWidgetController = controller;
//               print("INICIANDO O CONTROLADOR NO STATE");
//               controller.postMessage(
//                 'SceneControl',
//                 'LoadScene',
//                 widget.scene,
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//                 padding: const EdgeInsets.only(bottom: 50),
//                 child: FloatingActionButton(
//                   heroTag: 'bt2',
//                   backgroundColor: Colors.white,
//                   child: const Center(
//                     child: Icon(
//                       Icons.home,
//                       size: 35,
//                     ),
//                   ),
//                   onPressed: () {
//                     Get.toNamed('/home');
//                   },
//                 )),
//           ),
//           // Carrega a tela por 5 segundos

//         ],
//       ),