import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:game_laucher/util/util.dart';
import 'package:get/get.dart';

class Unity extends StatefulWidget {
  const Unity({super.key});

  @override
  State<Unity> createState() => _UnityState();
}

class _UnityState extends State<Unity> {
  UnityController unity = Get.find();
  var isLoading = true.obs;
  var isPaused = false.obs;
  var idPage = Get.parameters['id'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      unity.changeScene(idPage!);
      Future.delayed(const Duration(seconds: 3), () {
        isLoading(false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UnityWidget(
            onUnityCreated: (controller) {
              unity.onUnityCreated(controller);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  heroTag: 'home',
                  onPressed: () async {
                    if (await unity.unityController!.isLoaded() == true) {
                      await unity.unityController!.unload();
                    }
                    await unity.unityController!.resume();
                    Get.offNamed('/home');
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.home),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  return FloatingActionButton(
                    heroTag: 'pause',
                    onPressed: () async {
                      if (await unity.unityController!.isPaused() == true) {
                        unity.unityController!.resume();
                        isPaused(false);
                      } else {
                        unity.unityController!.pause();
                        isPaused(true);
                      }
                    },
                    backgroundColor: Colors.white,
                    child: Icon(
                      isPaused.value ? Icons.play_arrow : Icons.pause,
                    ),
                  );
                }),
                const SizedBox(height: 10),
                // FloatingActionButton(
                //   heroTag: 'resume',
                //   onPressed: () {
                //     unityWidgetController!.resume();
                //   },
                //   backgroundColor: Colors.white,
                //   child: const Icon(Icons.play_arrow),
                // ),
                // const SizedBox(height: 10),
                // FloatingActionButton(
                //   heroTag: 'unload',
                //   onPressed: () {
                //     unityWidgetController!.unload();
                //   },
                //   backgroundColor: Colors.white,
                //   child: const Icon(Icons.delete),
                // ),
              ],
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
  // void onUnityCreated(UnityWidgetController controller, String scene) {
  //   unityWidgetController = controller;
  //   changeScene(scene);
  // }

  // // Aciona o método de troca de cena da Unity.
  // void changeScene(String scene) async {
  //   unityWidgetController?.postMessage(
  //     'SceneControl',
  //     'LoadScene',
  //     scene,
  //   );
  // }
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