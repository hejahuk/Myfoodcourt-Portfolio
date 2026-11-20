import 'package:flutter/material.dart';

import 'package:food_court/widgets/homeCardvertical.dart';

import 'package:food_court/widgets/appBar.dart';
import 'package:food_court/widgets/edgecure.dart';

import 'package:food_court/widgets/PageSlider.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> products = [
      {
        'title': 'Chicken Rice',
        'category': 'Rice',
        'price': '\$4.5',
        'imageUrl':
            'assets/img/chicken_rice_logo.png',
      },
      {
        'title': 'Noodles King',
        'category': 'Noodles',
        'price': '\$6.5',
        'imageUrl':
            'assets/img/seafood_noddle.png',
      },
      {
        'title': 'Wrap',
        'category': 'wrap',
        'price': '\$4',
        'imageUrl':
            'assets/img/wrap.png',
      },
      {
        'title': 'Iced Tea',
        'category': 'Drinks',
        'price': '\$1.5',
        'imageUrl':
            'assets/img/coffee.png',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomCurvedEdges(),
              child: Container(
                color: const Color.fromARGB(232, 229, 33, 19),
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [myAppBar(), const SizedBox(height: 32)],
                ),
              ),
            ),

            /// -- Body Start: Carousel Slider
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: const pageSlider(),
            ),
            const SizedBox(height: 32),

            /// -- Product Grid with Unique Data
            GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
                mainAxisExtent: 270,
              ),
              itemBuilder: (_, index) {
                final product = products[index];
                return Center(
                  child: homeCardvertical(
                    dark: dark,
                    title: product['title']!,
                    category: product['category']!,
                    price: product['price']!,
                    imageUrl: product['imageUrl']!,
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
