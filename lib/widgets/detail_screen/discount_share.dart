import 'package:flutter/material.dart';

class DiscountShare extends StatelessWidget {
  final int stock;
  final double discount;

  const DiscountShare({
    super.key,
    required this.stock,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (stock != 0)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 26, 10),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Text(
                '${discount < 10 ? '0' : ''}${discount.toStringAsFixed(0)}%\noff',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 228, 222, 221),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
