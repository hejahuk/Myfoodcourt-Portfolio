import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_court/features/screens/personalization/re_authenticate_user_login_form.dart';
import 'package:food_court/utilies/repository/authentication_repository.dart';
import 'package:food_court/widgets/loader.dart';
import 'package:food_court/utilies/userModel.dart';
import 'package:food_court/utilies/repository/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = true.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final userModel = await userRepository.fetchUserDetails();
      user(userModel);
    } catch (e) {
      if (kDebugMode) print("DEBUG UserController.fetchUserRecord ERROR: $e");
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updateProfilePicture(String newImageUrl) async {
    try {
      profileLoading.value = true;

      await userRepository.updateSingleField({'ProfilePicture': newImageUrl});

      user.update((val) {
        if (val != null) {
          val.profilePicture = newImageUrl;
        }
      });

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your profile picture has been updated!',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Failed to update profile picture: $e',
      );
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      profileLoading.value = true;

      await userRepository.updateSingleField({'Username': newUsername});

      await fetchUserRecord();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your username has been updated!',
      );
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Failed to update username: $e',
      );
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    try {
      profileLoading.value = true;

      await userRepository.updateSingleField({'PhoneNumber': newPhoneNumber});

      await fetchUserRecord();

      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your phone number has been updated!',
      );
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Failed to update phone number: $e',
      );
    } finally {
      profileLoading.value = false;
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing',
        'assets/animations/loading.json',
      );

      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider == 'password') {
        TFullScreenLoader.stopLoading();
        Get.to(() => const ReAuthUserLoginForm());
      } else if (provider == 'google.com') {
        await auth.deleteAccount();
        TFullScreenLoader.stopLoading();
        auth.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing',
        'assets/animations/loading.json',
      );

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reauthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );

      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
