import 'package:flutter/material.dart';
import 'package:food_court/features/screens/loginscreen/login.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SucessScreen extends StatelessWidget {
  const SucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            top: 56 * 2,
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/img/sucess_screen.png")),
              const SizedBox(height: 32),

              Text(
                "Your Account successfully created",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
              Text(
                "Welcome to SPHub. Your account successfully created. Unleash the Joy of our food court app",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => Mylogin()),
                  child: Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
