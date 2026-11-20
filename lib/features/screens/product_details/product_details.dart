import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:food_court/features/controller/cart_controller.dart';
import 'package:food_court/features/screens/cart_screen/cart_screen.dart';
import 'package:food_court/features/controller/favorite_controller.dart';

import 'menu_data_provider.dart';
import 'product_calculator.dart';
import 'product_details_app_bar.dart';
import 'product_details_content.dart';

class ProductDetails extends StatefulWidget {
  final String title;
  final String category;
  final String price;
  final String imageUrl;

  const ProductDetails({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late double basePrice;
  late int baseCalories;
  late String currentImageUrl;
  double totalPrice = 0.0;
  int totalCalories = 0;
  int quantity = 1;
  final TextEditingController notesController = TextEditingController();
  String diningOption = 'Dine In';

  late CategoryMenuData menuData;
  Map<String, dynamic>? selectedSubType;

  Map<String, String> selectedSingles = {};
  Map<String, List<String>> selectedMultis = {};

  @override
  void initState() {
    super.initState();
    basePrice =
        double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    menuData = MenuDataProvider.forCategory(widget.category, widget.imageUrl);
    baseCalories = menuData.baseCalories;
    currentImageUrl = widget.imageUrl;

    if (menuData.subTypes.isNotEmpty) {
      selectedSubType = menuData.subTypes.first;
      currentImageUrl = selectedSubType!['img'];
    }

    _setDefaults();
    _recalculate();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  void _setDefaults() {
    for (var section in menuData.sections) {
      if (section.isMultiSelect) {
        selectedMultis[section.title] = [];
      } else if (section.options.isNotEmpty) {
        selectedSingles[section.title] = section.options.keys.first;
      }
    }
  }

  void _recalculate() {
    final price = ProductCalculator.totalPrice(
      basePrice: basePrice,
      subType: selectedSubType,
      sections: menuData.sections,
      selectedSingles: selectedSingles,
      selectedMultis: selectedMultis,
      quantity: quantity,
    );
    final calories = ProductCalculator.totalCalories(
      baseCalories: baseCalories,
      subType: selectedSubType,
      calorieOffsets: menuData.calorieOffsets,
      selectedSingles: selectedSingles,
      selectedMultis: selectedMultis,
      quantity: quantity,
    );
    setState(() {
      totalPrice = price;
      totalCalories = calories;
    });
  }

  void _toggleFavorite() {
    final favId = ProductCalculator.favoriteId(
      title: widget.title,
      subType: selectedSubType,
      selectedSingles: selectedSingles,
      selectedMultis: selectedMultis,
    );
    final optionsString = ProductCalculator.optionsSummary(
      subType: selectedSubType,
      selectedSingles: selectedSingles,
      selectedMultis: selectedMultis,
    );
    FavoriteController.instance.toggleFavorite(
      FavoriteItem(
        id: favId,
        title: widget.title,
        category: widget.category,
        price: '\$${totalPrice.toStringAsFixed(2)}',
        imageUrl: currentImageUrl,
        selectedOptions: optionsString,
      ),
    );
  }

  void _addToCart() {
    final dark = Theme.of(context).brightness == Brightness.dark;

    if (quantity <= 0) {
      Get.snackbar(
        'Invalid Quantity',
        'Please select at least 1 item.',
        backgroundColor: dark ? Colors.grey[900] : Colors.white,
        colorText: Colors.redAccent,
        icon: const Icon(Iconsax.warning_2, color: Colors.redAccent),
        borderWidth: 1,
        borderColor: Colors.redAccent.withOpacity(0.3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    bool missingRequired = false;
    for (var section in menuData.sections) {
      if (!section.isMultiSelect &&
          (selectedSingles[section.title] == null ||
              selectedSingles[section.title]!.isEmpty)) {
        missingRequired = true;
        break;
      }
    }

    if (missingRequired) {
      Get.snackbar(
        'Incomplete Selection',
        'Please ensure all required options are selected.',
        backgroundColor: dark ? Colors.grey[900] : Colors.white,
        colorText: Colors.orange,
        icon: const Icon(Iconsax.info_circle, color: Colors.orange),
        borderWidth: 1,
        borderColor: Colors.orange.withOpacity(0.3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    final optionsString = ProductCalculator.optionsSummary(
      subType: selectedSubType,
      selectedSingles: selectedSingles,
      selectedMultis: selectedMultis,
    );

    CartController.instance.addToCart(
      CartItem(
        id: DateTime.now().toString(),
        title: widget.title,
        imageUrl: currentImageUrl,
        unitPrice: totalPrice / quantity,
        quantity: quantity,
        selectedOptions: optionsString,
        calories: totalCalories,
      ),
    );

    Get.to(() => const CartScreen());
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBgColor = dark
        ? const Color(0xFF121212)
        : const Color(0xFFF9F9F9);

    final favId = ProductCalculator.favoriteId(
      title: widget.title,
      subType: selectedSubType,
      selectedSingles: selectedSingles,
      selectedMultis: selectedMultis,
    );

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: ProductDetailsAppBar(
        title: widget.title,
        dark: dark,
        favoriteId: favId,
        onFavoriteToggle: _toggleFavorite,
      ),
      body: ProductDetailsContent(
        dark: dark,
        title: widget.title,
        currentImageUrl: currentImageUrl,
        totalPrice: totalPrice,
        totalCalories: totalCalories,
        quantity: quantity,
        availableSubTypes: menuData.subTypes,
        selectedSubType: selectedSubType,
        menuSections: menuData.sections,
        selectedSingles: selectedSingles,
        selectedMultis: selectedMultis,
        diningOption: diningOption,
        notesController: notesController,
        onSubTypeSelected: (subType) {
          selectedSubType = subType;
          currentImageUrl = subType['img'];
          _recalculate();
        },
        onSingleSelected: (sectionTitle, optionKey) {
          selectedSingles[sectionTitle] = optionKey;
          _recalculate();
        },
        onMultiToggled: (sectionTitle, optionKey, isSelected) {
          if (isSelected) {
            selectedMultis[sectionTitle]!.remove(optionKey);
          } else {
            selectedMultis[sectionTitle]!.add(optionKey);
          }
          _recalculate();
        },
        onDiningOptionChanged: (option) =>
            setState(() => diningOption = option),
        onQuantityChanged: (newQty) {
          quantity = newQty;
          _recalculate();
        },
        onAddToCart: _addToCart,
      ),
    );
  }
}
