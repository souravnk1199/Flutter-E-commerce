import 'package:flutter/material.dart';

class BrandFilterDialog extends StatefulWidget {
  final Set<String> brands;
  final List<String> selectedBrands;
  final Function(List<String>) onApply;

  const BrandFilterDialog({
    super.key,
    required this.brands,
    required this.selectedBrands,
    required this.onApply,
  });

  @override
  State createState() => _BrandFilterDialogState();
}

class _BrandFilterDialogState extends State<BrandFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Select TV Brands')),
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: widget.brands.map((brand) {
            return FilterChip(
              label: Text(brand),
              selected: widget.selectedBrands.contains(brand),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    widget.selectedBrands.add(brand);
                  } else {
                    widget.selectedBrands.remove(brand);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              widget.selectedBrands.clear();
            });
          },
          child: const Text('Clear'),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(widget.selectedBrands);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
