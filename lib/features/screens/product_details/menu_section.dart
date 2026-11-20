class MenuSection {
  final String title;
  final bool isMultiSelect;
  final Map<String, double> options; // Name of option : Price offset
  MenuSection(this.title, this.options, {this.isMultiSelect = false});
}