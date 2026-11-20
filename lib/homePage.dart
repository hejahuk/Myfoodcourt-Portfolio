import 'package:flutter/material.dart';
import 'package:food_court/Pages/favorite.dart';
import 'package:food_court/Pages/home.dart';
import 'package:food_court/Pages/person.dart';
import 'package:food_court/Pages/shop.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPage = 0;

  void _navigateBottom(int index) {
    setState(() {
      currentPage = index;
    });
  }

  final List<Widget> _pages = [UserHome(), Shopping(), Favorite(), Person()];
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: _pages[currentPage],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: _navigateBottom,
        backgroundColor: dark ? Colors.black : Colors.white,
        indicatorColor: dark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.1),

        elevation: 0,
        height: 80,

        destinations: const [
          NavigationDestination(
            icon: Icon(Iconsax.home),
            selectedIcon: Icon(Iconsax.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Iconsax.shop),
            selectedIcon: Icon(Iconsax.shop),
            label: "Stores",
          ),

          NavigationDestination(
            icon: Icon(Iconsax.heart),
            selectedIcon: Icon(Iconsax.heart),
            label: "Favorite",
          ),

          NavigationDestination(
            icon: Icon(Iconsax.user),
            selectedIcon: Icon(Iconsax.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
