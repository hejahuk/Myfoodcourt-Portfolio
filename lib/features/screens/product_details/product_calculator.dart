import 'menu_section.dart';

class ProductCalculator {
  static double totalPrice({
    required double basePrice,
    required Map<String, dynamic>? subType,
    required List<MenuSection> sections,
    required Map<String, String> selectedSingles,
    required Map<String, List<String>> selectedMultis,
    required int quantity,
  }) {
    double total = basePrice;
    if (subType != null) total += (subType['priceOffset'] as double? ?? 0.0);

    selectedSingles.forEach((sectionTitle, optionName) {
      final section = sections.firstWhere((s) => s.title == sectionTitle);
      total += section.options[optionName] ?? 0.0;
    });

    selectedMultis.forEach((sectionTitle, optionNames) {
      final section = sections.firstWhere((s) => s.title == sectionTitle);
      for (final optionName in optionNames) {
        total += section.options[optionName] ?? 0.0;
      }
    });

    return total * quantity;
  }

  static int totalCalories({
    required int baseCalories,
    required Map<String, dynamic>? subType,
    required Map<String, Map<String, int>> calorieOffsets,
    required Map<String, String> selectedSingles,
    required Map<String, List<String>> selectedMultis,
    required int quantity,
  }) {
    int total = baseCalories;
    if (subType != null) total += (subType['calorieOffset'] as int? ?? 0);

    selectedSingles.forEach((sectionTitle, optionName) {
      total += calorieOffsets[sectionTitle]?[optionName] ?? 0;
    });

    selectedMultis.forEach((sectionTitle, optionNames) {
      for (final optionName in optionNames) {
        total += calorieOffsets[sectionTitle]?[optionName] ?? 0;
      }
    });

    return total * quantity;
  }

  static String optionsSummary({
    required Map<String, dynamic>? subType,
    required Map<String, String> selectedSingles,
    required Map<String, List<String>> selectedMultis,
  }) {
    final options = <String>[];
    if (subType != null) options.add(subType['name'] as String);
    selectedSingles.forEach((_, value) => options.add(value));
    selectedMultis.forEach((_, list) => options.addAll(list));
    return options.join(' • ');
  }

  static String favoriteId({
    required String title,
    required Map<String, dynamic>? subType,
    required Map<String, String> selectedSingles,
    required Map<String, List<String>> selectedMultis,
  }) {
    final options = <String>[];
    if (subType != null) options.add(subType['name'] as String);
    selectedSingles.forEach((_, value) => options.add(value));
    selectedMultis.forEach((_, list) => options.addAll(list));
    return '${title}_${options.join(' • ')}';
  }
}
