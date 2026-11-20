import 'package:flutter/material.dart';
import 'package:food_court/features/controller/cart_controller.dart';
import 'package:food_court/features/controller/favorite_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final favoriteController = FavoriteController.instance;
    final scaffoldBgColor = dark
        ? const Color(0xFF121212)
        : const Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Iconsax.home),
          onPressed: () {
            Get.until((route) => route.isFirst);
          },
        ),
        title: Text(
          "My Favorite",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() {
        // Empty State
        if (favoriteController.favoriteItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.heart, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No favorite items yet',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the heart icon in product details to save custom meals!',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          );
        }

        // Populated Custom List Layout
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: favoriteController.favoriteItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (_, index) {
            final favItem = favoriteController.favoriteItems[index];

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: dark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(dark ? 0.2 : 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 1. Custom Variant Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      favItem.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // 2. Title, Options & Price Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favItem.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          favItem.selectedOptions,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          favItem.price,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. Action Buttons (Quick Add to Cart & Delete)
                  Column(
                    children: [
                      // Quick Add to Cart Button
                      IconButton(
                        icon: const Icon(
                          Iconsax.shopping_cart,
                          color: Colors.blueAccent,
                          size: 22,
                        ),
                        onPressed: () {
                          final unitPrice =
                              double.tryParse(
                                favItem.price.replaceAll(
                                  RegExp(r'[^0-9.]'),
                                  '',
                                ),
                              ) ??
                              0.0;

                          // FIX: Added 'calories: 500' (or estimated based on price/item) to satisfy CartItem constructor requirements
                          CartController.instance.addToCart(
                            CartItem(
                              id: DateTime.now().toString(),
                              title: favItem.title,
                              imageUrl: favItem.imageUrl,
                              unitPrice: unitPrice,
                              quantity: 1,
                              selectedOptions: favItem.selectedOptions,
                              calories:
                                  500, // <--- Fixed missing required parameter error
                            ),
                          );

                          Get.snackbar(
                            'Added to Cart',
                            '${favItem.title} added successfully!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                      ),
                      // Remove from Favorites Button
                      IconButton(
                        icon: const Icon(
                          Iconsax.trash,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () =>
                            favoriteController.toggleFavorite(favItem),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
