import 'package:flutter/material.dart';
import 'package:food_court/features/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:food_court/features/screens/cart_screen/cart_screen.dart';

// ignore: camel_case_types
class myAppBar extends StatelessWidget {
  const myAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                "assets/img/splash_logo_light.png",
                color: Colors.white,
                height: 60,
                width: 90,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () => Get.to(() => const CartScreen()),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
              ),

              Obx(() {
                final itemCount = CartController.instance.cartItems.length;

                if (itemCount == 0) return const SizedBox.shrink();

                return Positioned(
                  right: 4,
                  top: 8,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
