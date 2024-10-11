// ignore_for_file: avoid_print

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:freela_fabiano/util/Util.dart';
import 'package:device_apps/device_apps.dart';
import 'package:open_file/open_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void launchGame() async {
    bool isInstalled = await DeviceApps.isAppInstalled('com.company.game');

    if (isInstalled) {
      DeviceApps.openApp('com.company.game');
    } else {
      print("Não instalado, abrindo instalador!");

      // Solicitar permissão para instalar pacotes
      var status = await Permission.requestInstallPackages.request();
      if (status.isGranted) {
        Directory tempDir = await getTemporaryDirectory();
        String apkPath = '${tempDir.path}/SpaceShooter.apk';

        try {
          ByteData data = await rootBundle.load('assets/game/SpaceShooter.apk');
          List<int> bytes = data.buffer.asUint8List();
          File apkFile = File(apkPath);
          await apkFile.writeAsBytes(bytes);

          OpenFile.open(apkPath);
        } catch (e) {
          print('Erro ao carregar o APK: $e');
        }
      } else {
        print("Permissão para instalar pacotes não foi concedida.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Widget: 👉${MediaQuery.sizeOf(context).width}");
    print("Height: 👉${MediaQuery.sizeOf(context).height}");
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          // Telas de tablet em paisagem.
          return Scaffold(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 45,
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
                          const Text(
                            "Bem-vindo à plataforma!",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              letterSpacing: 2,
                              fontFamily: "RobotoCondensed",
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                        horizontal: 50),
                                    child: Container(
                                      height: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    launchGame();
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: Util.height(context) * 0.4,
                                        decoration: BoxDecoration(
                                          border: const Border(
                                              left: BorderSide(
                                                color: Colors.white,
                                                width: 5,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.white,
                                                width: 5,
                                              )),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.red,
                                              Color(0xFFf86977),
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: Util.width(context) * .015,
                                            bottom: Util.width(context) * .015,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: Util.width(
                                                                context) *
                                                            .005,
                                                      ),
                                                      child: Image.asset(
                                                        'assets/images/joystick.png',
                                                        height: Util.width(
                                                                context) *
                                                            .03,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 10,
                                                        left: 10,
                                                      ),
                                                      child: SizedBox(
                                                        width: Util.width(
                                                                context) *
                                                            0.055,
                                                        child: FittedBox(
                                                          child: Text(
                                                            "GAME 1",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Lemonmilk-bold",
                                                              color: Colors
                                                                  .grey[200],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Image.asset(
                                                  'assets/images/mario-text2.png',
                                                  height: Util.height(context) *
                                                      .15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: Util.height(context) * -.1,
                                        right: Util.width(context) * -.1,
                                        child: Image.asset(
                                            'assets/images/mario.png',
                                            height: Util.height(context) *
                                                .5 // Link da imagem
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                flex: 1,
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
                                  Container(
                                    height: Util.height(context) * 0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (constraints.maxWidth > 600) {
          // Telas de tablet na vertical.
          return const SizedBox();
        } else {
          return const Text("Tela de Smarphone em pé.");
        }
      },
    );
  }
}
