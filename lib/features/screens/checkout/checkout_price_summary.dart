import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_court/features/screens/checkout/checkout_widget.dart';

import 'checkout_controller.dart';

class CheckoutPriceSummary extends StatelessWidget {
  final CheckoutController controller;
  final bool dark;

  const CheckoutPriceSummary({
    super.key,
    required this.controller,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SectionCard(
        dark: dark,
        child: Column(
          children: [
            PriceRow('Subtotal', controller.subtotal),
            const SizedBox(height: 8),
            PriceRow('Service Fee', controller.serviceFee),
            const SizedBox(height: 8),
            PriceRow('GST (9%)', controller.gst),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${controller.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),

            if (controller.splitCount.value > 1) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${controller.splitAmount.toStringAsFixed(2)} per person (${controller.splitCount.value} people)',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
