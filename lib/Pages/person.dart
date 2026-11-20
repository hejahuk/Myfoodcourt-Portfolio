import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_court/Pages/favorite.dart';
import 'package:food_court/features/screens/cart_screen/cart_screen.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:food_court/utilies/repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// Import your custom utilities and controllers
import 'package:food_court/features/screens/order/order.dart';
import 'package:food_court/features/screens/personalization/profile.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
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

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Stack(
        children: [
          if (!dark)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      projectColor.withOpacity(0.15),
                      projectColor.withOpacity(0.0),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Account",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                    const SizedBox(height: 24),

                    InkWell(
                      onTap: () => Get.to(() => const ProfileScreen()),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                dark ? 0.2 : 0.04,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final networkImage =
                                  controller.user.value.profilePicture;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: networkImage.isNotEmpty
                                    ? networkImage.startsWith('assets/')
                                        ? Image.asset(networkImage, width: 65, height: 65, fit: BoxFit.cover)
                                        : CachedNetworkImage(
                                        imageUrl: networkImage,
                                        width: 65,
                                        height: 65,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.person, size: 40),
                                      )
                                    : Container(
                                        width: 65,
                                        height: 65,
                                        color: dark
                                            ? Colors.grey[800]
                                            : Colors.grey[200],
                                        child: Icon(
                                          Icons.person,
                                          size: 40,
                                          color: dark
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                              );
                            }),
                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      controller.user.value.fullName.isNotEmpty
                                          ? controller.user.value.fullName
                                          : "User",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Obx(
                                    () => Text(
                                      controller.user.value.email,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: dark
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Icon(
                              Icons.chevron_right,
                              color: dark ? Colors.grey[500] : Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    const TSectionHeading(
                      title: "Food & Orders",
                      showActionButton: false,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(dark ? 0.2 : 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TSettingsMenuTile(
                            icon: Iconsax.bag_tick,
                            title: 'My Orders',
                            subTitle: 'Track active and past food orders',
                            onTap: () => Get.to(() => const MyOrdersScreen()),
                            dark: dark,
                          ),
                          _buildDivider(dark),
                          TSettingsMenuTile(
                            icon: Iconsax.shopping_cart,
                            title: 'My Cart',
                            subTitle: 'View items ready for checkout',
                            onTap: () => Get.to(() => const CartScreen()),
                            dark: dark,
                          ),
                          _buildDivider(dark),
                          TSettingsMenuTile(
                            icon: Iconsax.heart,
                            title: 'My Favorites',
                            subTitle: 'Quick access to your saved meals',
                            onTap: () => Get.to(() => const Favorite()),
                            dark: dark,
                          ),
                          _buildDivider(dark),
                          TSettingsMenuTile(
                            icon: Iconsax.award,
                            title: 'Food Passport 🛂',
                            subTitle: 'Track campus food stalls you visited',
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Food Passport',
                                middleText:
                                    '🍗 Chicken Rice (Visited)\n🍜 Noodles (Visited)\n🥤 Drinks (Pending)\n🌯 Wraps (Visited)\n\nProgress: 3/4 Stalls Visited!',
                                textConfirm: 'Awesome',
                                confirmTextColor: Colors.white,
                                onConfirm: () => Get.back(),
                              );
                            },
                            dark: dark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    const TSectionHeading(
                      title: 'App Settings',
                      showActionButton: false,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(dark ? 0.2 : 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TSettingsMenuTile(
                            icon: Iconsax.moon,
                            title: 'Dark Mode',
                            subTitle: 'Switch between light and dark themes',
                            dark: dark,
                            trailing: Switch(
                              value: dark,
                              activeThumbColor: projectColor,
                              onChanged: (value) {
                                Get.changeThemeMode(
                                  value ? ThemeMode.dark : ThemeMode.light,
                                );
                              },
                            ),
                          ),
                          _buildDivider(dark),
                          TSettingsMenuTile(
                            icon: Iconsax.support,
                            title: 'Help & Support',
                            subTitle: 'How to order at SP Food Court 1',
                            dark: dark,
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Help & FAQ',
                                middleText:
                                    '1. Choose a store from the home screen.\n2. Customize your meal.\n3. Checkout via PayNow or Card.\n4. Pick up your food!',
                                textConfirm: 'Got it',
                                confirmTextColor: Colors.white,
                                onConfirm: () => Get.back(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool dark) {
    return Padding(
      padding: const EdgeInsets.only(left: 64, right: 24),
      child: Divider(
        height: 1,
        thickness: 1,
        color: dark ? Colors.grey[800] : Colors.grey[200],
      ),
    );
  }
}

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = 'View all',
    required this.title,
    this.showActionButton = true,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showActionButton)
            TextButton(onPressed: onPressed, child: Text(buttonTitle)),
        ],
      ),
    );
  }
}

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
    required this.dark,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final projectColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Styled Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: projectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 24, color: projectColor),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: dark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: dark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            if (trailing != null)
              trailing!
            else
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
}
