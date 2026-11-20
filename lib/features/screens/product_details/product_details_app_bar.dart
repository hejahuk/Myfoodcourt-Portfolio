import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:food_court/features/controller/favorite_controller.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool dark;
  final String favoriteId;
  final VoidCallback onFavoriteToggle;

  const ProductDetailsAppBar({
    super.key,
    required this.title,
    required this.dark,
    required this.favoriteId,
    required this.onFavoriteToggle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final scaffoldBgColor = dark
        ? const Color(0xFF121212)
        : const Color(0xFFF9F9F9);
    final textColor = dark ? Colors.white : Colors.black87;
    final btnBgColor = dark ? Colors.grey[800] : Colors.white;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: scaffoldBgColor,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Center(
          child: InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: btnBgColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Iconsax.arrow_left, size: 20, color: textColor),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Obx(() {
              final isFav = FavoriteController.instance.isFavorite(favoriteId);
              return InkWell(
                onTap: onFavoriteToggle,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: btnBgColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Iconsax.heart,
                    color: isFav ? Colors.redAccent : textColor,
                    size: 20,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
