import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_laucher/app/ui/widgets/block_button.dart';
import 'package:game_laucher/util/util.dart';

class SideBarSuperMario extends StatelessWidget {
  const SideBarSuperMario({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF12284d),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: const Color(0xFF1c3966),
                width: 2,
              )),
          child: Stack(
            children: [
              // Nave!

              // Degradê para suavizar a transição para a cor de fundo
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Color(0xFF12284d),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 0.9],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/mario-jumpin.png',
                  height: Util.height(context) * .5,
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .moveY(
                      begin: -20,
                      end: 15,
                      curve: Curves.easeInOut,
                      duration: 1000.ms,
                    )
                    .then()
                    .moveY(begin: 15, end: -20, curve: Curves.easeInOut),
              ),
              Padding(
                padding: EdgeInsets.all(Util.height(context) * .03),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/mario-text2.png',
                    height: Util.height(context) * .20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlockButton(gameScene: 'SampleScene',),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
