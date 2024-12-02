import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_laucher/app/ui/widgets/block_button.dart';
import 'package:game_laucher/util/util.dart';

class SideBarSpaceShooter extends StatelessWidget {
  const SideBarSpaceShooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background-space.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
          // Nave!

          // Degradê para suavizar a transição para a cor de fundo
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0xFF102447),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 0.9], // Define onde o degradê começa
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/images/ship-normal2.png',
              height: Util.height(context) * .5,
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .moveY(
                  begin: -15,
                  end: 10,
                  curve: Curves.easeInOut,
                  duration: 1000.ms,
                )
                .then()
                .moveY(begin: 10, end: -15, curve: Curves.easeInOut),
          ),

          Padding(
            padding: EdgeInsets.all(Util.height(context) * .03),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/space-shooter.png',
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
                  color: Color(0xFFFF7043),
                  gameScene: 'GameScene',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
