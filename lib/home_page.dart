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
                      "Bem-vindo a nossa plataforma!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        letterSpacing: 2,
                        fontFamily: "RobotoCondensed",
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Games",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Lemonmilk",
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
                                height: 300, //alterar para porcentagem
                                decoration: BoxDecoration(
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
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontFamily: "RobotoCondensed",
                                          fontWeight: FontWeight.w900,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Super\n',
                                          ),
                                          TextSpan(
                                            text: "Mario",
                                            style: TextStyle(
                                              fontSize: 45,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'RobotoCondensed',
                                            ),
                                          ),
                                        ],
                                      ),
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
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        )
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
