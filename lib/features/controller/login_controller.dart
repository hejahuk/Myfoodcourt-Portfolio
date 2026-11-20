import 'package:flutter/material.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:food_court/utilies/repository/authentication_repository.dart';
import 'package:food_court/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    if (email.text.isNotEmpty) {
      rememberMe.value = true;
    }
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      if (loginFormKey.currentState == null ||
          !loginFormKey.currentState!.validate()) {
        TLoaders.warningSnackBar(
          title: 'Required Fields',
          message: 'Please fill in valid email and password fields.',
        );
        return;
      }

      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        localStorage.remove('REMEMBER_ME_EMAIL');
        localStorage.remove('REMEMBER_ME_PASSWORD');
      }

      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      await UserController.instance.fetchUserRecord();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Login Failed', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Logging in with Google...',
        'assets/animations/loading.json',
      );

      await AuthenticationRepository.instance.signInWithGoogle();

      TFullScreenLoader.stopLoading();

      await UserController.instance.fetchUserRecord();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Google Sign-In Failed',
        message: e.toString(),
      );
    }
  }
}
