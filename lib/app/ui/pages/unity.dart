import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:game_laucher/app/ui/widgets/bot_loading_widget.dart';
import 'package:game_laucher/app/ui/widgets/space_loading_widget.dart';
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
  RxInt highScore = 0.obs;
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
            onUnityMessage: (handler) {
              debugPrint(handler.toString());
              int score = int.parse(handler);
              if (score > highScore.value) {
                highScore(score);
              }
            },
          ),
          Obx(() {
            return isPaused.value
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.2),
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
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Util.width(context) * .2,
                            child: FittedBox(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: "LemonMilk-bold",
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'RECORDE\n',
                                    ),
                                    TextSpan(
                                      text: highScore.string,
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
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
                        ],
                      ),
                    ),
                  )
                : const SizedBox();
          }),
          Obx(() {
            if (isLoading.value) {
              if (idPage == "GameScene") {
                return const SpaceLoadingWidget();
              }
              return const BotLoadingWidget();
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }
}
