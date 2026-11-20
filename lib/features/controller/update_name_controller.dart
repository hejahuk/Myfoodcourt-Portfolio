import 'package:flutter/material.dart';
import 'package:food_court/Pages/person.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:food_court/widgets/loader.dart';
import 'package:food_court/utilies/repository/user_repository.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();

  final userController = UserController.instance;
  final userRepository = Get.isRegistered<UserRepository>()
      ? UserRepository.instance
      : Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      if (updateUserNameFormKey.currentState == null ||
          !updateUserNameFormKey.currentState!.validate()) {
        return;
      }

      TFullScreenLoader.openLoadingDialog(
        'Updating information...',
        'assets/animations/loading.json',
      );

      Map<String, dynamic> nameData = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(nameData);

      userController.user.update((val) {
        if (val != null) {
          val.firstName = firstName.text.trim();
          val.lastName = lastName.text.trim();
        }
      });
      await Future.delayed(const Duration(seconds: 2));

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your Name has been updated.',
      );

      Get.to(() => Person());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
