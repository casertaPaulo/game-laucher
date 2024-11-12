import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';

class UnityController extends GetxController {
  UnityWidgetController? unityController;

  void onUnityCreated(UnityWidgetController unityWidgetController) {
    unityController = unityWidgetController;
  }

  // Aciona o método de troca de cena da Unity.
  changeScene(String scene) async {
    unityController?.postMessage(
      'SceneControl',
      'LoadScene',
      scene,
    );
  }
}
