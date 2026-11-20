import 'menu_section.dart';

class CategoryMenuData {
  final int baseCalories;
  final List<Map<String, dynamic>> subTypes;
  final List<MenuSection> sections;

  final Map<String, Map<String, int>> calorieOffsets;

  const CategoryMenuData({
    required this.baseCalories,
    required this.subTypes,
    required this.sections,
    required this.calorieOffsets,
  });
}

class MenuDataProvider {
  static CategoryMenuData forCategory(String category, String defaultImageUrl) {
    switch (category) {
      case 'Rice':
        return _rice(defaultImageUrl);
      case 'Drinks':
        return _drinks(defaultImageUrl);
      case 'Noodles':
        return _noodles(defaultImageUrl);
      default:
        return _wraps(defaultImageUrl);
    }
  }

  static CategoryMenuData _rice(String img) {
    return CategoryMenuData(
      baseCalories: 600,
      subTypes: [
        {'name': 'Roasted Chicken', 'priceOffset': 0.0, 'calorieOffset': 0, 'img': img},
        {
          'name': 'Steamed Chicken',
          'priceOffset': 1.0,
          'calorieOffset': -50,
          'img':
              'assets/img/chicken_rice_logo.png',
        },
      ],
      sections: [
        MenuSection('Size', {'Small': 0.0, 'Medium': 1.5, 'Large': 3.0}),
        MenuSection('Rice Type', {'White Rice': 0.0, 'Brown Rice': 0.5, 'Extra Rice': 1.0, 'No Rice': 0.0}),
        MenuSection('Meat Portion', {'Regular': 0.0, 'Extra Chicken': 2.0, 'Double Chicken': 4.0}),
        MenuSection('Sauce', {'Chili Sauce': 0.0, 'Ginger Sauce': 0.0, 'Dark Soy Sauce': 0.0, 'All Sauces': 0.0, 'No Sauce': 0.0}),
        MenuSection('Spice Level', {'No Chili': 0.0, 'Mild': 0.0, 'Medium': 0.0, 'Spicy': 0.0}),
        MenuSection('Add-ons', isMultiSelect: true, {'Fried Egg': 1.20, 'Braised Egg': 0.80, 'Tofu': 1.50, 'Vegetables': 1.50, 'Soup': 1.00}),
      ],
      calorieOffsets: {
        'Size': {'Small': 0, 'Medium': 100, 'Large': 220},
        'Rice Type': {'White Rice': 0, 'Brown Rice': 10, 'Extra Rice': 150, 'No Rice': -180},
        'Meat Portion': {'Regular': 0, 'Extra Chicken': 150, 'Double Chicken': 300},
        'Sauce': {'Chili Sauce': 5, 'Ginger Sauce': 5, 'Dark Soy Sauce': 10, 'All Sauces': 20, 'No Sauce': 0},
        'Spice Level': {'No Chili': 0, 'Mild': 0, 'Medium': 0, 'Spicy': 0},
        'Add-ons': {'Fried Egg': 120, 'Braised Egg': 90, 'Tofu': 80, 'Vegetables': 25, 'Soup': 60},
      },
    );
  }

  static CategoryMenuData _drinks(String img) {
    return CategoryMenuData(
      baseCalories: 200,
      subTypes: [
        {'name': 'Standard', 'priceOffset': 0.0, 'calorieOffset': 0, 'img': img},
        {
          'name': 'Matcha',
          'priceOffset': 0.5,
          'calorieOffset': 40,
          'img':
              'assets/img/matcha.png',
        },
      ],
      sections: [
        MenuSection('Size', {'Small': 0.0, 'Medium': 1.0, 'Large': 2.0}),
        MenuSection('Temperature', {'Hot': 0.0, 'Iced': 0.5}),
        MenuSection('Sugar Level', {'0%': 0.0, '25%': 0.0, '50%': 0.0, '75%': 0.0, '100%': 0.0}),
        MenuSection('Ice Level', {'No Ice': 0.0, 'Less Ice': 0.0, 'Regular': 0.0, 'Extra Ice': 0.0}),
        MenuSection('Milk Choice', {'Fresh Milk': 0.0, 'Oat Milk': 1.0, 'Soy Milk': 1.0, 'No Milk': 0.0}),
        MenuSection('Coffee Strength', {'Light': 0.0, 'Regular': 0.0, 'Strong': 0.5}),
        MenuSection('Add-ons', isMultiSelect: true, {'Extra Espresso Shot': 1.50, 'Whipped Cream': 1.20, 'Caramel Syrup': 0.80, 'Vanilla Syrup': 0.80}),
      ],
      calorieOffsets: {
        'Size': {'Small': 0, 'Medium': 80, 'Large': 150},
        'Temperature': {'Hot': 0, 'Iced': 0},
        'Sugar Level': {'0%': -80, '25%': -40, '50%': 0, '75%': 30, '100%': 60},
        'Ice Level': {'No Ice': 20, 'Less Ice': 10, 'Regular': 0, 'Extra Ice': -10},
        'Milk Choice': {'Fresh Milk': 30, 'Oat Milk': 25, 'Soy Milk': 20, 'No Milk': 0},
        'Coffee Strength': {'Light': 0, 'Regular': 0, 'Strong': 10},
        'Add-ons': {'Extra Espresso Shot': 5, 'Whipped Cream': 100, 'Caramel Syrup': 60, 'Vanilla Syrup': 60},
      },
    );
  }

  static CategoryMenuData _noodles(String img) {
    return CategoryMenuData(
      baseCalories: 550,
      subTypes: [
        {'name': 'Chicken', 'priceOffset': 0.0, 'calorieOffset': 0, 'img': img},
        {
          'name': 'Beef',
          'priceOffset': 2.0,
          'calorieOffset': 150,
          'img':
              'assets/img/beef_noddle.png',
        },
        {
          'name': 'Seafood',
          'priceOffset': 3.0,
          'calorieOffset': 80,
          'img':
              'assets/img/seafood_noddle.png',
        },
        {
          'name': 'Vegetarian',
          'priceOffset': -1.0,
          'calorieOffset': -100,
          'img':
              'assets/img/vege_noddle.png',
        },
      ],
      sections: [
        MenuSection('Size', {'Small': 0.0, 'Medium': 1.5, 'Large': 3.0}),
        MenuSection('Noodle Type', {'Egg Noodles': 0.0, 'Udon': 1.0, 'Rice Noodles': 0.0, 'Instant Noodles': 0.0}),
        MenuSection('Soup', {'Soup': 0.0, 'Dry': 0.0, 'Less Soup': 0.0}),
        MenuSection('Meat Portion', {'Regular': 0.0, 'Extra Meat': 2.5, 'Double Meat': 4.5}),
        MenuSection('Spice Level', {'No Spice': 0.0, 'Mild': 0.0, 'Medium': 0.0, 'Hot': 0.0, 'Extra Hot': 0.0}),
        MenuSection('Garnish', {'Spring Onion': 0.0, 'Coriander': 0.0, 'Fried Onion': 0.0, 'No Garnish': 0.0}),
        MenuSection('Add-ons', isMultiSelect: true, {'Fish Ball': 1.50, 'Fish Cake': 1.50, 'Egg': 1.00, 'Dumplings': 2.50, 'Cheese': 1.50}),
      ],
      calorieOffsets: {
        'Size': {'Small': 0, 'Medium': 100, 'Large': 220},
        'Noodle Type': {'Egg Noodles': 0, 'Udon': 60, 'Rice Noodles': -30, 'Instant Noodles': 40},
        'Soup': {'Soup': 40, 'Dry': 0, 'Less Soup': 20},
        'Meat Portion': {'Regular': 0, 'Extra Meat': 180, 'Double Meat': 350},
        'Spice Level': {'No Spice': 0, 'Mild': 0, 'Medium': 0, 'Hot': 0, 'Extra Hot': 0},
        'Garnish': {'Spring Onion': 0, 'Coriander': 0, 'Fried Onion': 15, 'No Garnish': 0},
        'Add-ons': {'Fish Ball': 90, 'Fish Cake': 100, 'Egg': 120, 'Dumplings': 180, 'Cheese': 110},
      },
    );
  }

  static CategoryMenuData _wraps(String img) {
    return CategoryMenuData(
      baseCalories: 450,
      subTypes: [
        {'name': 'Grilled Chicken', 'priceOffset': 0.0, 'calorieOffset': 0, 'img': img},
        {
          'name': 'Beef',
          'priceOffset': 1.5,
          'calorieOffset': 150,
          'img':
              'assets/img/beef_wrap.png',
        },
        {
          'name': 'Tuna',
          'priceOffset': 0.5,
          'calorieOffset': 40,
          'img':
              'assets/img/tuna_wrap.png',
        },
        {
          'name': 'Vegetarian',
          'priceOffset': 0.5,
          'calorieOffset': -80,
          'img':
              'assets/img/vege_wrap.png',
        },
      ],
      sections: [
        MenuSection('Size', {'Regular': 0.0, 'Large': 2.0}),
        MenuSection('Wrap Type', {'Original': 0.0, 'Whole Wheat': 0.0, 'Spinach': 0.5, 'Gluten-Free': 1.0}),
        MenuSection('Cheese', {'None': 0.0, 'Cheddar': 1.0, 'Mozzarella': 1.0}),
        MenuSection('Sauce', {'Mayonnaise': 0.0, 'Garlic Sauce': 0.0, 'BBQ Sauce': 0.0, 'Honey Mustard': 0.0, 'Sweet Chili': 0.0, 'No Sauce': 0.0}),
        MenuSection('Toasting', {'Not Toasted': 0.0, 'Lightly Toasted': 0.0, 'Well Toasted': 0.0}),
        MenuSection('Cut Style', {'Whole': 0.0, 'Half': 0.0}),
        MenuSection('Vegetables', isMultiSelect: true, {'Lettuce': 0.0, 'Tomato': 0.0, 'Onion': 0.0, 'Cucumber': 0.0, 'Pickles': 0.0, 'Corn': 0.0}),
        MenuSection('Add-ons', isMultiSelect: true, {'Extra Meat': 2.50, 'Extra Cheese': 1.50, 'Avocado': 2.00, 'Bacon': 2.00}),
      ],
      calorieOffsets: {
        'Size': {'Regular': 0, 'Large': 180},
        'Wrap Type': {'Original': 0, 'Whole Wheat': 10, 'Spinach': 0, 'Gluten-Free': 20},
        'Cheese': {'None': 0, 'Cheddar': 110, 'Mozzarella': 90},
        'Sauce': {'Mayonnaise': 90, 'Garlic Sauce': 40, 'BBQ Sauce': 30, 'Honey Mustard': 35, 'Sweet Chili': 25, 'No Sauce': 0},
        'Toasting': {'Not Toasted': 0, 'Lightly Toasted': 10, 'Well Toasted': 20},
        'Cut Style': {'Whole': 0, 'Half': 0},
        'Vegetables': {'Lettuce': 5, 'Tomato': 5, 'Onion': 5, 'Cucumber': 5, 'Pickles': 5, 'Corn': 15},
        'Add-ons': {'Extra Meat': 150, 'Extra Cheese': 110, 'Avocado': 80, 'Bacon': 90},
      },
    );
  }
}