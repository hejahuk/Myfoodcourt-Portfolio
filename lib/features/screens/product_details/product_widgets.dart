import 'package:flutter/material.dart';

class ProductSectionContainer extends StatelessWidget {
  final bool dark;
  final String title;
  final String subtitle;
  final Widget child;

  const ProductSectionContainer({
    super.key,
    required this.dark,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: dark ? Colors.grey[900] : Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class ProductRadioRow extends StatelessWidget {
  final bool dark;
  final String name;
  final double priceOffset;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductRadioRow({
    super.key,
    required this.dark,
    required this.name,
    required this.priceOffset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(child: Text(name, style: const TextStyle(fontSize: 16))),
            if (priceOffset > 0)
              Text(
                '+\$${priceOffset.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            const SizedBox(width: 12),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.redAccent : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCheckboxRow extends StatelessWidget {
  final bool dark;
  final String name;
  final double priceOffset;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductCheckboxRow({
    super.key,
    required this.dark,
    required this.name,
    required this.priceOffset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(child: Text(name, style: const TextStyle(fontSize: 16))),
            if (priceOffset > 0)
              Text(
                '+\$${priceOffset.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            const SizedBox(width: 12),
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.redAccent : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
