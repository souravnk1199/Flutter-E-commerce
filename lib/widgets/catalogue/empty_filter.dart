import 'package:flutter/material.dart';

class EmptyFilter extends StatelessWidget {
  final void Function() onClear;

  const EmptyFilter({
    super.key,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Ooops, No Items Matched!',
            style: TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: onClear,
            child: const Text(
              'Clear Filters',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 35, 147, 135),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
