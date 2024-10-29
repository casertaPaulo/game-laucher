import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:game_laucher/app/ui/pages/home_page.dart';
import 'package:get/get.dart';

class Unity extends StatefulWidget {
  final String scene;
  const Unity({super.key, required this.scene});

  @override
  State<Unity> createState() => _UnityState();
}

class _UnityState extends State<Unity> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;

  // Callback que conecta o controller criado ao UnityWidgetController
  void onUnityCreated(UnityWidgetController controller) {
    setState(() {
      _unityWidgetController = controller;
    });
  }

  void changeScene(String scene) {
    _unityWidgetController.postMessage(
      'SceneControl',
      'LoadScene',
      widget.scene,
    );
  }

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: PopScope(
          child: Stack(
            children: [
              UnityWidget(
                onUnityCreated: onUnityCreated,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Center(
                          child: Icon(
                            Icons.change_circle,
                            size: 35,
                          ),
                        ),
                        onPressed: () {
                          changeScene(widget.scene);
                        },
                      ),
                      const SizedBox(width: 25),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Center(
                          child: Icon(
                            Icons.home,
                            size: 35,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _unityWidgetController.dispose();
                          });
                          Get.off(
                            () => const HomePage(),
                          );
                        },
                      ),
                      const SizedBox(width: 25),
                      const Text(
                        "Jogo",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'LemonMilk-bold',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
