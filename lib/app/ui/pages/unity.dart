import 'dart:ui';

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
            unloadOnDispose: false,
            onUnityCreated: (controller) {
              unity.onUnityCreated(controller);
            },
          ),
          Obx(() {
            return isPaused.value
                ? Expanded(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(),
                    ),
                  )
                : const SizedBox();
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloatingActionButton(
                  heroTag: 'home',
                  onPressed: () async {
                    if (await unity.unityController!.isLoaded() == true) {
                      //await unity.unityController!.unload();
                    }
                    await unity.unityController!.resume();
                    Get.offNamed('/home');
                  },
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.close,
                    color: Colors.redAccent,
                  ),
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
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                    child: Icon(
                      isPaused.value ? Icons.play_arrow : Icons.pause,
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            return isPaused.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: Util.width(context) * .3,
                        child: const FittedBox(
                          child: Text(
                            "JOGO PAUSADO",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "LEMONMILK-BOLD",
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
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
}
