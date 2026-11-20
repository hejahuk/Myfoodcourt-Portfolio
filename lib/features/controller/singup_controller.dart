import 'package:flutter/material.dart';
import 'package:food_court/features/screens/singupscreen/verify_email.dart';
import 'package:food_court/utilies/repository/authentication_repository.dart';
import 'package:food_court/widgets/loader.dart';
import 'package:food_court/utilies/userModel.dart';
import 'package:food_court/utilies/repository/user_repository.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacypolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        'assets/animations/loading.json',
      );

      if (!privacypolicy.value) {
        TFullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create an account, you must read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      await UserController.instance.fetchUserRecord();

      TLoaders.successSnackBar(
        title: "Congratulations",
        message: "Your account have been created! Verify email to continue",
      );

      Get.to(() => VerifyEmailScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
