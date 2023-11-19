import 'package:flutter/material.dart';

class ItemButtonStyle extends StatelessWidget {
  final String label;
  final void Function() onPressButton;
  const ItemButtonStyle({
    super.key,
    required this.label,
    required this.onPressButton,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressButton,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.white,
        ), // Background color
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Border radius
        )),
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Colors.grey, // Border color
            width: 1.0, // Border width
          ),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
