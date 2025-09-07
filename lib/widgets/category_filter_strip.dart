import 'package:flutter/material.dart';

class CategoryFilterStrip extends StatelessWidget {
  final List<String> categories;
  final String? selected;
  final ValueChanged<String>? onChanged;
  const CategoryFilterStrip({super.key, this.categories = const ['Painting', 'Digital', 'Jewelry', 'Clothing', 'Photography', 'Sculpture'], this.selected, this.onChanged});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (_, i) {
          final c = categories[i];
          final sel = selected == null ? false : selected == c;
          return ChoiceChip(
            label: Text(c),
            selected: sel,
            onSelected: (_) => onChanged?.call(c),
            selectedColor: scheme.primaryContainer,
            side: BorderSide(color: scheme.onSurface.withValues(alpha: 0.15)),
            labelStyle: Theme.of(context).textTheme.labelLarge,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}