import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_court/features/screens/checkout/checkout_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'checkout_controller.dart';

class CheckoutOptionsSection extends StatelessWidget {
  final CheckoutController controller;
  final bool dark;

  const CheckoutOptionsSection({
    super.key,
    required this.controller,
    required this.dark,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
            child: Text(
              'Split Bill',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SectionCard(
            dark: dark,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Iconsax.people, color: Colors.blueAccent),
                    SizedBox(width: 12),
                    Text('Number of Friends', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.decrementSplit,
                      icon: const Icon(Iconsax.minus_cirlce),
                      color: Colors.grey,
                    ),
                    Text(
                      '${controller.splitCount.value}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.incrementSplit,
                      icon: const Icon(Iconsax.add_circle),
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
            child: Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SectionCard(
            dark: dark,
            padding: EdgeInsets.zero,
            child: RadioGroup<String>(
              groupValue: controller.selectedPayment.value,
              onChanged: (String? value) {
                if (value != null) {
                  controller.selectedPayment.value = value;
                }
              },
              child: Column(
                children: ['PayNow', 'Credit/Debit Card', 'Cash'].map((method) {
                  return RadioListTile<String>(
                    title: Text(method),

                    value: method,
                    activeColor: Colors.redAccent,
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            dark: dark,
            child: Column(
              children: [
                CheckboxListTile(
                  title: const Text('No Plastic Cutlery'),
                  subtitle: const Text(
                    'Save the environment 🌱',
                    style: TextStyle(color: Colors.green),
                  ),
                  value: controller.isEcoFriendly.value,
                  activeColor: Colors.green,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) => controller.isEcoFriendly.value = value!,
                ),
                const Divider(),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Order Note (e.g., Less ice, extra chili)',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 13),
                    border: InputBorder.none,
                    icon: const Icon(Iconsax.note_text),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
