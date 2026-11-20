import 'package:food_court/features/controller/onboard_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Myonboard extends StatelessWidget {
  const Myonboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controlller = Get.put(OnBoardingController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controlller.pageController,
            onPageChanged: controlller.updatePageIndicator,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/img/searching_onboard.png",
                      width: screenWidth * 0.8,
                      height: screenHeigth * 0.6,
                    ),
                    Text(
                      "Discover Delicious Meals",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Browse your favorite food court stalls in seconds.",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/img/second_onboard.png",
                      width: screenWidth * 0.8,
                      height: screenHeigth * 0.6,
                    ),
                    Text(
                      "Order Before You Arrive",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Place your order anytime and let your meal be prepared.",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/img/third_onboard.png",
                      width: screenWidth * 0.8,
                      height: screenHeigth * 0.6,
                    ),
                    Text(
                      "Skip the Queue",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Pick up your meal quickly and enjoy more time to eat.",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: kToolbarHeight,
            right: 16,
            child: TextButton(
              onPressed: () => OnBoardingController.instance.skipPage(),
              child: Text("Skip", style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          dotonboard(),
          eleonboard(),
        ],
      ),
    );
  }
}

class eleonboard extends StatelessWidget {
  const eleonboard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      right: 20,
      bottom: kBottomNavigationBarHeight + 15,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        child: Icon(
          Iconsax.arrow_circle_right,
          color: dark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class dotonboard extends StatelessWidget {
  const dotonboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      bottom: kBottomNavigationBarHeight + 25,
      left: 16,

      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? Colors.white : Colors.black,
          dotHeight: 6,
        ),
      ),
    );
  }
}
