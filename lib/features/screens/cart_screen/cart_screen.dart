import 'package:flutter/material.dart';
import 'package:food_court/features/controller/cart_controller.dart';
import 'package:food_court/features/screens/checkout/checkoutscreen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final cartController = CartController.instance;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false, 
        leading: IconButton(
          icon: const Icon(Iconsax.home), 
          onPressed: () {
            Get.until((route) => route.isFirst); 
          },
        ),
        title: Text("Cart", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.shopping_cart, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text('Your cart is empty', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text('Add some delicious food to get started!', style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          );
        }

        
        final int totalCartCalories = cartController.cartItems.fold(
          0, 
          (sum, item) => sum + (item.calories * item.quantity),
        );

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartController.cartItems.length,
                  separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(),
                  ),
                  itemBuilder: (_, index) {
                    final item = cartController.cartItems[index];

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  item.imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 16),
                              
                              
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: Theme.of(context).textTheme.titleLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.selectedOptions,
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    
                                    Row(
                                      children: [
                                        const Icon(Iconsax.flash, size: 14, color: Colors.orange),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${item.calories * item.quantity} kcal', 
                                          style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '\$${item.unitPrice.toStringAsFixed(2)} each',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.redAccent, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => cartController.removeOne(index),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: dark ? Colors.grey[800] : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Icon(Icons.remove, size: 18, color: dark ? Colors.white : Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '${item.quantity}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () => cartController.addOne(index),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: const Icon(Icons.add, size: 18, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),

                              
                              Text(
                                '\$${(item.unitPrice * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Iconsax.flash, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Total Meal Energy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      Text(
                        '$totalCartCalories kcal',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      
      
      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) return const SizeCacheBox();

        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: dark ? Colors.grey[900] : Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
          ),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              "Checkout \$${cartController.totalCartPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        );
      }),
    );
  }
}


class SizeCacheBox extends StatelessWidget {
  const SizeCacheBox({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}