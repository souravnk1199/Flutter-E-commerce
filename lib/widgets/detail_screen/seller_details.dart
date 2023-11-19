import 'package:flutter/material.dart';

class SellerDetails extends StatelessWidget {
  final String seller;
  const SellerDetails({
    super.key,
    required this.seller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Sold by ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: seller.toUpperCase(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 10, 90, 165),
                    fontSize: 16,
                  ),
                ),
                const TextSpan(
                  text: " and ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const TextSpan(
                  text: "Fulfilled by Amazon",
                  style: TextStyle(
                    color: Color.fromARGB(255, 10, 90, 165),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
