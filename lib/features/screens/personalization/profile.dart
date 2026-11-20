import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_court/features/screens/personalization/change_name.dart';
import 'package:food_court/features/screens/personalization/change_profile_picture.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:food_court/features/screens/personalization/change_username.dart';
import 'package:food_court/features/screens/personalization/change_phone.dart';
import 'package:food_court/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final dark = Theme.of(context).brightness == Brightness.dark;

    final projectColor = Theme.of(context).primaryColor;

    final scaffoldBgColor = dark
        ? const Color(0xFF121212)
        : const Color(0xFFF9F9F9);
    final cardColor = dark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = dark ? Colors.white : Colors.black87;
    final subtitleColor = dark ? Colors.grey[400] : Colors.grey[600];

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Stack(
        children: [
          if (!dark)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 350,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      projectColor.withValues(alpha: 0.15),
                      projectColor.withValues(alpha: 0.0),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: dark ? Colors.grey[800] : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Iconsax.arrow_left, size: 20),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Profile',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: dark ? 0.2 : 0.04),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Obx(() {
                            final networkImage =
                                controller.user.value.profilePicture;
                            return Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dark
                                    ? Colors.grey[800]
                                    : Colors.grey[50],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: networkImage.isNotEmpty
                                    ? (networkImage.startsWith('assets/')
                                        ? AssetImage(networkImage)
                                        : NetworkImage(networkImage))
                                    : null,
                                child: networkImage.isEmpty
                                    ? const Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                            );
                          }),
                          const SizedBox(height: 16),

                          Obx(
                            () => Text(
                              controller.user.value.fullName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),

                          Obx(
                            () => Text(
                              controller.user.value.email,
                              style: TextStyle(
                                fontSize: 14,
                                color: subtitleColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.user,
                                size: 14,
                                color: subtitleColor,
                              ),
                              const SizedBox(width: 4),
                              Obx(
                                () => Text(
                                  '@${controller.user.value.username}  •  Foodie',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: subtitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          ElevatedButton.icon(
                            onPressed: () => Get.to(
                              () => const ChangeProfilePictureScreen(),
                            ),
                            icon: const Icon(
                              Iconsax.edit_2,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: projectColor,
                              elevation: 0,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: dark ? 0.2 : 0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Iconsax.user_edit,
                            title: 'Change Name',
                            onTap: () => Get.to(() => const ChangeName()),
                            dark: dark,
                          ),
                          _buildDivider(dark),
                          _buildMenuItem(
                            icon: Iconsax.link,
                            title: 'Change Username',
                            onTap: () => Get.to(() => const ChangeUsername()),
                            dark: dark,
                          ),
                          _buildDivider(dark),
                          _buildMenuItem(
                            icon: Iconsax.call,
                            title: 'Change Phone',
                            onTap: () => Get.to(() => const ChangePhone()),
                            dark: dark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: dark ? 0.2 : 0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Iconsax.copy,
                            title: 'Copy Account ID',
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: controller.user.value.id),
                              );
                              TLoaders.successSnackBar(
                                title: 'Copied!',
                                message: 'User ID copied to clipboard.',
                              );
                            },
                            dark: dark,
                          ),
                          _buildDivider(dark),
                          _buildMenuItem(
                            icon: Iconsax.trash,
                            title: 'Close Account',
                            iconColor: Colors.redAccent,
                            textColor: Colors.redAccent,
                            onTap: () => controller.deleteAccountWarningPopup(),
                            dark: dark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool dark,
    Color? iconColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: iconColor ?? (dark ? Colors.grey[300] : Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? (dark ? Colors.white : Colors.black87),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: dark ? Colors.grey[600] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool dark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        thickness: 1,
        color: dark ? Colors.grey[800] : Colors.grey[200],
      ),
    );
  }
}
