import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class ExtraInformation extends StatelessWidget {
  final String offer;
  final bool onPrime;

  const ExtraInformation({
    super.key,
    required this.offer,
    required this.onPrime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          offer,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        Row(
          children: [
            if (onPrime)
              Image.asset(
                'assets/prime.png',
                width: 50,
              ),
            if (onPrime)
              const SizedBox(
                width: 15,
              ),
            const Text("Free Delivery by"),
          ],
        ),
        Text(
          Utils.formattedDate(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
