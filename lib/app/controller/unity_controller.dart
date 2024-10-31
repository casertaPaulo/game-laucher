import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';

class UnityController extends GetxController {
  UnityWidgetController? unityWidgetController;

  var isUnityLoaded = false.obs;
  var isLoading = false.obs;

  void changeScene(String scene) async {
    unityWidgetController?.postMessage(
      'SceneControl',
      'LoadScene',
      scene,
    );
  }
}
