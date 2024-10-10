import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "LEMONMILK",
                        ),
                        children: [
                          TextSpan(
                            text: 'Olá, ',
                          ),
                          TextSpan(
                            text: "Paulo",
                            style: TextStyle(
                              fontSize: 35,
                              fontFamily: 'LemonMilk-bold',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
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
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: MediaQuery.sizeOf(context).height * 0.4,
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
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 30),
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
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Image.asset(
                                                'assets/images/joystick.png',
                                                height: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                              ),
                                              child: Text(
                                                "GAME 1",
                                                style: TextStyle(
                                                  fontFamily: "Lemonmilk-bold",
                                                  fontSize: 17,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          'assets/images/mario-text2.png',
                                          height: 120,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -100,
                                right: -40,
                                child: Image.asset(
                                  'assets/images/mario.png', // Link da imagem
                                  height: 400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 1,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ],
                          ),
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
  }
}
