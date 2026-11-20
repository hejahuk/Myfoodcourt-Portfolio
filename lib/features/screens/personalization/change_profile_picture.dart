import 'package:flutter/material.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:get/get.dart';

class ChangeProfilePictureScreen extends StatelessWidget {
  const ChangeProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> profileImages = [
      'assets/img/avatar_coral.png',
      'assets/img/avatar_mint.png',
      'assets/img/avatar_sky.png',
      'assets/img/avatar_peach.png',
      'assets/img/avatar_lavender.png',
      'assets/img/avatar_rose.png',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Profile Picture')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: profileImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemBuilder: (context, index) {
            
            final imageUrl = profileImages[index];

            return GestureDetector(
              onTap: () {
                UserController.instance.updateProfilePicture(imageUrl);

                Get.back();
                Future.delayed(const Duration(milliseconds: 300), () {
                  Get.snackbar(
                    'Success',
                    'Profile picture updated!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                });
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(imageUrl),
                backgroundColor: Colors.grey[200],
              ),
            );
          },
        ),
      ),
    );
  }
}
