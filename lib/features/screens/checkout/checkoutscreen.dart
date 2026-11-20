import 'package:flutter/material.dart';
import 'package:food_court/features/screens/checkout/checkout_widget.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'checkout_controller.dart';

import 'checkout_summary_section.dart';
import 'checkout_options_section.dart';
import 'checkout_price_summary.dart';
import 'checkout_bottom_bar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBgColor = dark
        ? const Color(0xFF121212)
        : const Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: dark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: dark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.cart.cartItems.isEmpty) {
          return const CheckoutEmptyState();
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckoutSummarySection(controller: controller, dark: dark),
                CheckoutOptionsSection(controller: controller, dark: dark),
                const SizedBox(height: 16),
                CheckoutPriceSummary(controller: controller, dark: dark),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.cart.cartItems.isEmpty) return const SizedBox.shrink();
        return CheckoutBottomBar(controller: controller, dark: dark);
      }),
    );
  }
}
