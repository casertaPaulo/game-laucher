import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(child: SvgPicture.asset("assets/images/splash-image.svg")),
      nextScreen: const Placeholder(),
      nextRoute: '/home',
      backgroundColor: const Color(0xFF102447),
      duration: 2000,
      curve: Curves.easeInOut,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
