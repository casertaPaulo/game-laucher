import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_laucher/util/util.dart';

class SpaceLoadingWidget extends StatelessWidget {
  const SpaceLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
      ),
    );
  }
}
