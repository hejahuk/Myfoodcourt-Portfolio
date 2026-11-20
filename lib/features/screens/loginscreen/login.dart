import 'package:flutter/material.dart';
import 'package:food_court/features/screens/loginscreen/login_divider.dart';
import 'package:food_court/features/screens/loginscreen/login_form.dart';
import 'package:food_court/features/screens/loginscreen/login_hrader.dart';
import 'package:food_court/features/screens/loginscreen/login_socialbutton.dart';
class Mylogin extends StatelessWidget {
  const Mylogin({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(
          top: 60,
          bottom: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            LoginHeader(),
            LoginForm(),
            login_divider(dark: dark),
            const SizedBox(height: 16,),
            LoginSocialButton(),
          ],
        ),),
      ),
    );
  }
}
