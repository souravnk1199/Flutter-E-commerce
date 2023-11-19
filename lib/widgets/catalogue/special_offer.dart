import 'package:flutter/material.dart';

class SpecialOffer extends StatelessWidget {
  final String text;
  final double size;

  const SpecialOffer({
    super.key,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size,
        ),
      ),
    );
  }
}
