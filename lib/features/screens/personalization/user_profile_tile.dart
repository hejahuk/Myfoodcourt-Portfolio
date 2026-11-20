import 'package:flutter/material.dart';
import 'package:food_court/features/screens/personalization/profile.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:get/get.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        child: Icon(Icons.person, size: 30),
      ),
      title: Obx(
        () => Text(
          controller.user.value.fullName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
      ),
      subtitle: Obx(
        () => Text(
          controller.user.value.email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
