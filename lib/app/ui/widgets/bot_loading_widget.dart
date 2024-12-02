import 'package:flutter/material.dart';

class BotLoadingWidget extends StatelessWidget {
  const BotLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a002a),
      body: Stack(
        children: [
          // Imagem background do jogo
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/bot-full.png',
            ),
          ),
          // Efeito de gradient por cima da imagem
          _buildGradient(),

          // Circular indicator para mostrar o Loading
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color(0xFF102447),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: [0.1, 0.9],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
