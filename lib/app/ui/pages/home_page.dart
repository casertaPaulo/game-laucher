// ignore_for_file: avoid_print

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/app/controller/home_controller.dart';
import 'package:game_laucher/app/controller/unity_controller.dart';
import 'package:game_laucher/app/ui/components/side_bar_space_shooter.dart';
import 'package:game_laucher/app/ui/components/side_bar_bot_jump.dart';
import 'package:game_laucher/app/ui/components/space_shooter_card.dart';
import 'package:game_laucher/app/ui/components/bot_jump_card.dart';
import 'package:game_laucher/util/util.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    UnityController unity = Get.find();
    print("Widget: 👉${MediaQuery.sizeOf(context).width}");
    print("Height: 👉${MediaQuery.sizeOf(context).height}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF102447),
        body: Stack(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: UnityWidget(
                onUnityCreated: (controller) {
                  unity.onUnityCreated(controller);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF102447),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Util.width(context) * .03,
                        vertical: Util.height(context) * .05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              elevation: 4,
                              color: const Color(0xFF12284d),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  Util.height(context) * .025,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      //color: Colors.blue,
                                      width: Util.width(context) * .25,
                                      child: FittedBox(
                                        child: RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              fontSize: 50,
                                              fontFamily: "LemonMilk-bold",
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Bem-',
                                              ),
                                              TextSpan(
                                                text: "Vindo",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      //color: Colors.red,
                                      width: Util.width(context) * .25,
                                      height: Util.height(context) * .07,
                                      child: FittedBox(
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          "Exercite-se enquanto joga!",
                                          style: TextStyle(
                                            color: Colors.grey[300],
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "RobotoCondensed",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Games",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: "Lemonmilk-bold",
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        child: Container(
                                          height: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Util.height(context) * .05,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isBotJumpSelected.value =
                                            false;
                                        print("CLicou no SpaceShooter");
                                      },
                                      child: Obx(
                                        () => const SpaceShooterCard()
                                            .animate()
                                            .fadeIn(duration: 500.ms)
                                            .then()
                                            .scaleXY(
                                              begin: 1,
                                              end: controller
                                                      .isBotJumpSelected.value
                                                  ? 0.9
                                                  : 1.1,
                                            ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Util.width(context) * .025),
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isBotJumpSelected.value =
                                            true;
                                        print("CLicou no SuperMario");
                                      },
                                      child: Obx(
                                        () => const BotJumpCard()
                                            .animate()
                                            .fadeIn(duration: 500.ms)
                                            .then()
                                            .scaleXY(
                                              begin: 1,
                                              curve: Curves.elasticOut,
                                              duration: 1500.ms,
                                              end: controller
                                                      .isBotJumpSelected.value
                                                  ? 1.1
                                                  : 0.9,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    return controller.isBotJumpSelected.value
                        ? const SideBarBotJump()
                        : const SideBarSpaceShooter();
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    );

    /*
    
    LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          // Telas de tablet em paisagem.
          return 
        } else if (constraints.maxWidth > 600) {
          // Telas de tablet na vertical.
          return const SizedBox();
        } else {
          return const Text("Tela de Smarphone em pé.");
        }
      },
    );
    
    
    */
  }
}
