import 'package:flutter/material.dart';
import 'package:game_laucher/util/util.dart';

class SpaceShooterCard extends StatelessWidget {
  const SpaceShooterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: Util.height(context) * 0.4,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/background-space.png"),
                fit: BoxFit.fill),
            border: const Border(
                left: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                )),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        // IMAGEM DA NAVE
        Positioned(
          top: Util.height(context) * -.05,
          right: Util.width(context) * -.025,
          child: Image.asset(
            'assets/images/ship-normal2.png',
            height: Util.height(context) * .51,
          ),
        ),
        // IMAGEM
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
                      "GAME 1",
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
            'assets/images/space-shooter.png',
            height: Util.height(context) * .15,
          ),
        ),
      ],
    );
  }
}
