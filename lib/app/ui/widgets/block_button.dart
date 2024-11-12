import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_laucher/util/util.dart';
import 'package:get/get.dart';

class BlockButton extends StatelessWidget {
  final String gameScene;
  const BlockButton({super.key, required this.gameScene});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
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
                Get.offNamed('/unity/$gameScene');
              },
              label: const Text(
                "JOGAR",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ))
          .animate(
            onComplete: (controller) {
              controller.stop();
            },
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
          ),
    );
  }
}
