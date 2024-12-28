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
  RxBool isLoading = true.obs;
  RxBool isPaused = false.obs;
  RxInt highScore = 0.obs;
  var idPage = Get.parameters['id'];

  // Executa o método de troca de Scene assim que a tela é carregada com o WidgetsBinding.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      unity.changeScene(idPage!);
      //Espera um tempinho até que a Scene tenha sido carregado por completo. UX Improve.
      //isLoading define se vou mostrar uma tela de Loading por cima da Unity (enquanto carrega) ou não
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
          // Mostra a widget da Unity (Game)
          _buildUnity(),
          // Mostra o recorde no canto superior direito
          _buildHighScore(),
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
      // Passa o controller da Unity ao carregar a Widget do Unity
      onUnityCreated: (controller) {
        unity.onUnityCreated(controller);
      },
      // Recebe a mensagem do score quando a nave é destruida
      onUnityMessage: (handler) {
        debugPrint(handler.toString());
        int score = int.parse(handler);
        // Lógica para setar o valor do Score caso seja atualizado
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

  Widget _buildHighScore() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30),
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: Get.width * .14,
          height: Get.height * .13,
          child: Obx(() {
            int highestScore = highScore.value;
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
                      text: highestScore == 0 ? "N/A" : highestScore.toString(),
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
              // Dá play no jogo caso esteja pausado ao sair. Sem fazer isso, a Unity buga.
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
            // Gerencia o state do botão PAUSE ( Ícone e Método )
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
