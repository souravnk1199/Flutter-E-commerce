import 'package:flutter/material.dart';

class CurrentlyUnAvailable extends StatelessWidget {
  const CurrentlyUnAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Currently unavailable',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Color.fromARGB(255, 2, 128, 76),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'We don\'t know when or if this item will be back in stock.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
