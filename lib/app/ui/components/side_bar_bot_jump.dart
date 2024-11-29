import 'package:flutter/material.dart';
import 'package:game_laucher/app/ui/widgets/block_button.dart';
import 'package:game_laucher/util/util.dart';

class SideBarBotJump extends StatelessWidget {
  const SideBarBotJump({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            // Degradê para suavizar a transição para a cor de fundo
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1a002a), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 0.8],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/bot-jump-panel-edit.png',
                  height: Util.height(context) * .62,
                )),
            Padding(
              padding: EdgeInsets.all(Util.height(context) * .03),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/bot-jumping-text.png',
                  height: Util.height(context) * .20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlockButton(
                    gameScene: 'PinkScene',
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
