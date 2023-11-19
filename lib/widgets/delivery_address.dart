import 'package:flutter/material.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 143, 247, 249),
            Color.fromARGB(255, 165, 248, 213)
          ],
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined),
          SizedBox(width: 10),
          Text('Deliver to Sourav - Bengaluru 560100'),
          SizedBox(width: 10),
          Icon(Icons.keyboard_arrow_down_outlined),
        ],
      ),
    );
  }
}
