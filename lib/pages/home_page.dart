// ignore_for_file: avoid_print

import 'package:flutter_animate/flutter_animate.dart';
import 'package:freela_fabiano/pages/widgets/side_bar_space_shooter.dart';
import 'package:freela_fabiano/pages/widgets/side_bar_super_mario.dart';
import 'package:freela_fabiano/pages/widgets/space_shooter_card.dart';
import 'package:freela_fabiano/pages/widgets/super_mario_card.dart';
import 'package:freela_fabiano/service/game_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:freela_fabiano/util/Util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final GameService _gameService = Get.find<GameService>();
  RxBool marioSelect = false.obs;

  @override
  void initState() {
    super.initState();
    _gameService.hasPermission();
    _gameService.isAppInstalled();
    WidgetsBinding.instance.addObserver(this);
  }

  // Verifica quando o usuário retorna ao contexto do app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _gameService.isInstalling.value = false;
      await _gameService.isAppInstalled();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Widget: 👉${MediaQuery.sizeOf(context).width}");
    print("Height: 👉${MediaQuery.sizeOf(context).height}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF102447),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF102447),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Util.width(context) * .03,
                    vertical: Util.height(context) * .05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            //color: Colors.redAccent,
                            width: Util.width(context) * .25,
                            child: FittedBox(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontFamily: "RobotoCondensed",
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Olá, ',
                                    ),
                                    TextSpan(
                                      text: "Paulo",
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontFamily: 'RobotoCondensed',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SizedBox(
                              //color: Colors.blue,
                              width: Util.width(context) * .2,
                              child: const FittedBox(
                                child: Text(
                                  "Bem-vindo à plataforma!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 2,
                                    fontFamily: "RobotoCondensed",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                const Text(
                                  "Games",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "Lemonmilk-bold",
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Container(
                                      height: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Util.height(context) * .05,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    marioSelect.value = false;
                                    print("CLicou no SpaceShooter");
                                  },
                                  child: Obx(
                                    () => const SpaceShooterCard()
                                        .animate()
                                        .fadeIn(duration: 500.ms)
                                        .then()
                                        .scaleXY(
                                          begin: 1,
                                          end: marioSelect.value ? 0.9 : 1.1,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Util.width(context) * .025),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    marioSelect.value = true;
                                    print("CLicou no SuperMario");
                                  },
                                  child: Obx(
                                    () => const SuperMarioCard()
                                        .animate()
                                        .fadeIn(duration: 500.ms)
                                        .then()
                                        .scaleXY(
                                          begin: 1,
                                          curve: Curves.elasticOut,
                                          duration: 1500.ms,
                                          end: marioSelect.value ? 1.1 : 0.9,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return marioSelect.value
                      ? SideBarSuperMario(gameService: _gameService)
                      : SideBarSpaceShooter(gameService: _gameService);
                },
              ),
            )
          ],
        ),
      ),
    );

    /*
    
    LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          // Telas de tablet em paisagem.
          return 
        } else if (constraints.maxWidth > 600) {
          // Telas de tablet na vertical.
          return const SizedBox();
        } else {
          return const Text("Tela de Smarphone em pé.");
        }
      },
    );
    
    
    */
  }
}
