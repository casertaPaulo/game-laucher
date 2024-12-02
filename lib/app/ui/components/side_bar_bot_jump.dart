import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_laucher/app/ui/widgets/block_button.dart';
import 'package:get/get.dart';

class SideBarBotJump extends StatelessWidget {
  const SideBarBotJump({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // Degradê para suavizar a transição para a cor de fundo
          _buildGradientBackground(),
          _buildHeaderText(),
          _buildImage(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
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
    );
  }

  Widget _buildHeaderText() {
    return Padding(
      padding: EdgeInsets.all(Get.height * .03),
      child: Align(
        alignment: Alignment.topLeft,
        child: Image.asset(
          'assets/images/bot-jumping-text.png',
          height: Get.height * .20,
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/bot-pannel.png',
        height: Get.height * .50,
      )
          .animate(
            onPlay: (controller) => controller.repeat(),
          )
          .moveY(
            begin: -10,
            end: 5,
            curve: Curves.easeInOut,
            duration: 1000.ms,
          )
          .then()
          .moveY(begin: 5, end: -10, curve: Curves.easeInOut),
    );
  }

  Widget _buildButton() {
    return const Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlockButton(
            color: Color(0xFFff64b1),
            gameScene: 'PinkScene',
          ),
        ],
      ),
    );
  }
}
