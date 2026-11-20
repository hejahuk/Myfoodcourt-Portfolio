import 'package:flutter/material.dart';

import 'package:food_court/features/screens/onboarding_screen.dart';
import 'package:food_court/main.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyScrollBehavior(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          primary: Colors.redAccent,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.redAccent,
        colorScheme: const ColorScheme.dark(primary: Colors.redAccent),
      ),
      home: Myonboard(),
    );
  }
}
