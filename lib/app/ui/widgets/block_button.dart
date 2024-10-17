import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freela_fabiano/app/controller/game_controller.dart';

import 'package:freela_fabiano/util/Util.dart';
import 'package:get/get.dart';

class BlockButton extends StatelessWidget {
  final GameController gameController;
  const BlockButton({super.key, required this.gameController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Obx(
          () {
            var state = gameController;
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.all(
                    Util.height(context) * .03,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: "LemonMilk-bold",
                  )),
              onPressed: () {
                state.launchGame();
              },
              label: state.isInstalling.value
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      state.isGameInstalled.value ? "JOGAR" : "INSTALAR",
                      style: const TextStyle(color: Colors.white),
                    ),
              icon: !state.isInstalling.value
                  ? Icon(
                      state.isGameInstalled.value
                          ? Icons.play_arrow
                          : Icons.install_mobile,
                      color: Colors.white,
                    )
                  : null,
            )
                .animate(
                  onComplete: (controller) => controller.stop(),
                )
                .fadeIn(
                  curve: Curves.easeInOut,
                  duration: 1000.ms,
                )
                .slideY(begin: 10, duration: 1000.ms, curve: Curves.elasticOut)
                .shimmer(
                  delay: 1500.ms,
                  duration: 1500.ms,
                  curve: Curves.easeInOut,
                );
          },
        ));
  }
}
