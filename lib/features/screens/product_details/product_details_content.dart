import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'menu_section.dart';
import 'product_widgets.dart';

class ProductDetailsContent extends StatelessWidget {
  final bool dark;
  final String title;
  final String currentImageUrl;
  final double totalPrice;
  final int totalCalories;
  final int quantity;
  final List<Map<String, dynamic>> availableSubTypes;
  final Map<String, dynamic>? selectedSubType;
  final List<MenuSection> menuSections;
  final Map<String, String> selectedSingles;
  final Map<String, List<String>> selectedMultis;
  final String diningOption;
  final TextEditingController notesController;

  final Function(Map<String, dynamic>) onSubTypeSelected;
  final Function(String, String) onSingleSelected;
  final Function(String, String, bool) onMultiToggled;
  final Function(String) onDiningOptionChanged;
  final Function(int) onQuantityChanged;
  final VoidCallback onAddToCart;

  const ProductDetailsContent({
    super.key,
    required this.dark,
    required this.title,
    required this.currentImageUrl,
    required this.totalPrice,
    required this.totalCalories,
    required this.quantity,
    required this.availableSubTypes,
    required this.selectedSubType,
    required this.menuSections,
    required this.selectedSingles,
    required this.selectedMultis,
    required this.diningOption,
    required this.notesController,
    required this.onSubTypeSelected,
    required this.onSingleSelected,
    required this.onMultiToggled,
    required this.onDiningOptionChanged,
    required this.onQuantityChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    currentImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey[900] : Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${(totalPrice / (quantity == 0 ? 1 : quantity)).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Iconsax.flash,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '$totalCalories kcal',
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                if (availableSubTypes.length > 1) ...[
                  ProductSectionContainer(
                    dark: dark,
                    title: 'Choice of Protein/Type',
                    subtitle: 'Required • Select 1',
                    child: Column(
                      children: availableSubTypes.map((subType) {
                        final isSelected =
                            selectedSubType?['name'] == subType['name'];
                        return ProductRadioRow(
                          dark: dark,
                          name: subType['name'],
                          priceOffset: subType['priceOffset'],
                          isSelected: isSelected,
                          onTap: () => onSubTypeSelected(subType),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                ...menuSections.map((section) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ProductSectionContainer(
                      dark: dark,
                      title: section.title,
                      subtitle: section.isMultiSelect
                          ? 'Optional • Select multiple'
                          : 'Required • Select 1',
                      child: Column(
                        children: section.options.entries.map((entry) {
                          if (section.isMultiSelect) {
                            final isSelected = selectedMultis[section.title]!
                                .contains(entry.key);
                            return ProductCheckboxRow(
                              dark: dark,
                              name: entry.key,
                              priceOffset: entry.value,
                              isSelected: isSelected,
                              onTap: () => onMultiToggled(
                                section.title,
                                entry.key,
                                isSelected,
                              ),
                            );
                          } else {
                            final isSelected =
                                selectedSingles[section.title] == entry.key;
                            return ProductRadioRow(
                              dark: dark,
                              name: entry.key,
                              priceOffset: entry.value,
                              isSelected: isSelected,
                              onTap: () =>
                                  onSingleSelected(section.title, entry.key),
                            );
                          }
                        }).toList(),
                      ),
                    ),
                  );
                }),

                ProductSectionContainer(
                  dark: dark,
                  title: 'Dining Option',
                  subtitle: 'Required • Select 1',
                  child: Column(
                    children: ['Dine In', 'Takeaway'].map((option) {
                      return ProductRadioRow(
                        dark: dark,
                        name: option,
                        priceOffset: 0.0,
                        isSelected: diningOption == option,
                        onTap: () => onDiningOptionChanged(option),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),

                ProductSectionContainer(
                  dark: dark,
                  title: 'Special Requests',
                  subtitle: 'Optional',
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: 'e.g., Less rice, more cucumber...',
                        filled: true,
                        fillColor: dark ? Colors.grey[800] : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) onQuantityChanged(quantity - 1);
                    },
                    icon: Icon(
                      Iconsax.minus_cirlce,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    '$quantity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => onQuantityChanged(quantity + 1),
                    icon: Icon(
                      Iconsax.add_circle,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ElevatedButton(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add - \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
