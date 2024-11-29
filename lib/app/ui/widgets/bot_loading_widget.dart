import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:game_laucher/util/util.dart';

class BotLoadingWidget extends StatelessWidget {
  const BotLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1a002a),
                  Color(0xFF102447),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: [0.5, 0.9], // Define onde o degradê começa
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/bot-full.png',
            ),
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
