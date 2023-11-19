import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final Color color;
  final String text;
  final void Function() onPressButton;
  const BigButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressButton,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text(text),
            ),
          ),
        ),
      ],
    );
  }
}
