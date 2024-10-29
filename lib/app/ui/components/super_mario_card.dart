import 'package:flutter/material.dart';
import 'package:game_laucher/util/util.dart';

class SuperMarioCard extends StatelessWidget {
  const SuperMarioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: Util.height(context) * 0.4,
          decoration: BoxDecoration(
            border: const Border(
                left: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
            gradient: const LinearGradient(
              colors: [
                Colors.red,
                Color(0xFFf86977),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Positioned.fill(
          top: Util.height(context) * -.1,
          right: Util.width(context) * -.1,
          child: Image.asset('assets/images/mario.png',
              height: Util.height(context) * .5 // Link da imagem
              ),
        ),
        Positioned(
          top: Util.height(context) * .05,
          left: Util.width(context) * .02,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Util.width(context) * .005,
                ),
                child: Image.asset(
                  'assets/images/joystick.png',
                  height: Util.width(context) * .03,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: SizedBox(
                  width: Util.width(context) * 0.055,
                  child: FittedBox(
                    child: Text(
                      "GAME 2",
                      style: TextStyle(
                        fontFamily: "Lemonmilk-bold",
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: Util.height(context) * .05,
          left: Util.width(context) * .02,
          child: Image.asset(
            'assets/images/mario-text2.png',
            height: Util.height(context) * .15,
          ),
        ),
      ],
    );
  }
}
