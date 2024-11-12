import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';

class UnityController extends GetxController {
  UnityWidgetController? unityController;

  void onUnityCreated(
    UnityWidgetController unityWidgetController,
    String scene,
  ) async {
    unityController = unityWidgetController;
    changeScene(scene);
    Future.delayed(const Duration(seconds: 2), () {
      unityController!.pause();
    });
  }

  // Aciona o método de troca de cena da Unity.
  void changeScene(String scene) async {
    unityController?.postMessage(
      'SceneControl',
      'LoadScene',
      scene,
    );
  }
}
