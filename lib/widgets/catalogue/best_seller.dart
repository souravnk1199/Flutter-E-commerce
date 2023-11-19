import 'package:flutter/material.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          color: Colors.red, // Background color for the tag
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0), // Adjust the border radius as needed
            bottomRight:
                Radius.circular(8.0), // Adjust the border radius as needed
          ),
        ),
        child: const Text(
          'Best Seller',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0, // Adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
