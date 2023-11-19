import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class DiscountedPrice extends StatelessWidget {
  final double price;
  final double discount;

  const DiscountedPrice({
    super.key,
    required this.price,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final discountedPrice = Utils.calculateDiscountedPrice(price, discount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Utils.getFormattedNumber(discountedPrice.toInt()),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            const Text(
              'M.R.P:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 68, 68, 68),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              Utils.getFormattedNumber(price.toInt()),
              style: const TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 68, 68, 68),
              ),
            ),
            Flexible(flex: 1, child: Container()),
            Text(
              '(${discount.toInt()}% off)',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 195, 100, 4)),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ],
    );
  }
}
