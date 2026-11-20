import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:food_court/features/screens/order/order.dart';
import 'package:food_court/features/controller/order_control.dart';

import 'checkout_controller.dart';

class CheckoutBottomBar extends StatelessWidget {
  final CheckoutController controller;
  final bool dark;

  const CheckoutBottomBar({
    super.key,
    required this.controller,
    required this.dark,
  });

  void _placeOrder(BuildContext context) {
    final orderNumber = '#A${100 + Random().nextInt(900)}';

    final newOrder = OrderModel(
      orderId: orderNumber,
      date: 'Today, ${TimeOfDay.now().format(context)}',
      status: 'Preparing',
      totalPrice: controller.total,
      totalCalories: controller.totalCalories,
      items: List.from(controller.cart.cartItems),
    );

    OrderController.instance.placeOrder(newOrder);
    controller.cart.cartItems.clear();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: dark ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.tick_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text(
              'Order Received!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Your Order Number: $orderNumber',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.off(() => const MyOrdersScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  'Track My Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Get.until((route) => route.isFirst),
              child: const Text(
                'Back to Home',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: dark ? Colors.grey[900] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _placeOrder(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Place Order',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
