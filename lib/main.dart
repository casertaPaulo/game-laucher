import 'package:flutter/material.dart';
import 'package:freela_fabiano/pages/home_page.dart';
import 'package:freela_fabiano/pages/web_view_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/webview', page: () => const WebViewPage()),
      ],
      home: const Scaffold(
        body: HomePage(),
      ),
    );
  }
}
