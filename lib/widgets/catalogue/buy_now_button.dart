import 'package:flutter/material.dart';

class BuyNow extends StatelessWidget {
  const BuyNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 8.0), // Adjust padding here
              ),
              backgroundColor: MaterialStateProperty.all<Color?>(
                  const Color.fromARGB(255, 255, 255, 255)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Set the border radius here
                ),
              ),
            ),
            child: const Text(
              'Add to Compare',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
