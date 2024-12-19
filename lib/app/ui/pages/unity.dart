import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:game_laucher/app/ui/components/side_bar_bot_jump.dart';
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
  RxBool isLoading = true.obs;
  RxBool isPaused = false.obs;
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
          // Mostra a widget da Unity
          _buildUnity(),
          // Mostra o recorde no canto superior direito
          _buildHighScore(),
          // Mostra um pop-up com a mensagem de record quebrado
          _buildTriggerMessage(),
          // Mostra um blur de background quando está pausado
          _buildBlueWhenIsPaused(),
          // Mostra a tela de pause
          _buildPausedScreen(),
          // Mostra os botões laterais
          _buildButtons(),
          // Mostra a widget de Loading enquanto a unity carrega
          _buildLoadingWidget(),
        ],
      ),
    );
  }

  Widget _buildUnity() {
    return UnityWidget(
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
    );
  }

  Widget _buildBlueWhenIsPaused() {
    return Obx(() {
      if (isPaused.value) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.2),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _buildPausedScreen() {
    return Obx(() {
      if (isPaused.value) {
        return Padding(
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
        );
      }

      return const SizedBox();
    });
  }

  Widget _buildTriggerMessage() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                size: 50,
                color: Colors.amber,
              ),
              SizedBox(
                width: Get.width * .13,
                height: Get.height * .13,
                child: FittedBox(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "LemonMilk-bold",
                      ),
                      children: [
                        TextSpan(
                            text: 'RECORDE\n',
                            style: TextStyle(
                              color: Colors.grey[300],
                            )),
                        const TextSpan(
                          text: "BATIDO!",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .moveX(
          begin: 150,
          end: 0,
          duration: 2000.ms,
          curve: Curves.fastLinearToSlowEaseIn,
        );
  }

  Widget _buildHighScore() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30),
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: Get.width * .14,
          height: Get.height * .13,
          child: Obx(() {
            return FittedBox(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: "LemonMilk-bold",
                  ),
                  children: [
                    TextSpan(
                        text: 'RECORDE\n',
                        style: TextStyle(
                          color: Colors.grey[300],
                        )),
                    TextSpan(
                      text: highScore.value.toString(),
                      style: const TextStyle(
                        fontFamily: "ROBOTOCONDENSED",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
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
    );
  }

  Widget _buildLoadingWidget() {
    return Obx(() {
      if (!isLoading.value) {
        return const SizedBox();
      }
      if (idPage == "SpaceScene") {
        return const SpaceLoadingWidget();
      }
      return const BotLoadingWidget();
    });
  }
}
