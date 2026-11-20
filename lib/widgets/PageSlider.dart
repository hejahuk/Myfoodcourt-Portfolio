import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_court/Pages/favorite.dart';
import 'package:food_court/features/screens/cart_screen/cart_screen.dart';
import 'package:food_court/features/screens/order/order.dart';
import 'package:get/get.dart';

class pageSlider extends StatefulWidget {
  const pageSlider({super.key});

  @override
  State<pageSlider> createState() => _pageSliderState();
}

class _pageSliderState extends State<pageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> banners = [
      {
        'url':
            'assets/img/cart_banner.jpg',
        'page': const CartScreen(),
      },
      {
        'url':
            'assets/img/favorite_banner.jpg',
        'page': const Favorite(),
      },
      {
        'url':
            'assets/img/myorder_banner.jpg',
        'page': MyOrdersScreen(),
      },
    ];

    return Column(
      children: [
        CarouselSlider(
          items: banners.map((banner) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // 1. Force GetX to recognize this as a valid screen
                    Get.to(() => banner['page'] as Widget);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      banner['url'] as String,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 3. Dynamically count the dots based on how many banners you have
            for (int i = 0; i < banners.length; i++)
              Container(
                width: 20,
                height: 5,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: currentIndex == i ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
