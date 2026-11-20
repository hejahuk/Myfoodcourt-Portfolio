import 'package:flutter/material.dart';
import 'package:food_court/features/controller/login_controller.dart';
import 'package:get/get.dart';

class LoginSocialButton extends StatelessWidget {
  const LoginSocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: dark ? Colors.grey[700]! : Colors.grey[300]!),
            borderRadius: BorderRadius.circular(100),
            color: dark ? Colors.grey[900] : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: Image.asset(
              "assets/img/google.png",
              width: 22,
              height: 22,
            ),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }
}