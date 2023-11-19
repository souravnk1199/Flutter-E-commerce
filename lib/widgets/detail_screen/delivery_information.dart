import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class DeliveryInformation extends StatelessWidget {
  final int stock;
  const DeliveryInformation({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "FREE scheduled delivery as soon as \n",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: Utils.formattedDate(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(
                      text: ". Details",
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
        ),
        const SizedBox(
          height: 8,
        ),
        const Row(
          children: [
            Icon(Icons.location_on_outlined),
            SizedBox(
              width: 10,
            ),
            Text(
              "Deliver to Sourav - Bengaluru 560100",
              style: TextStyle(
                color: Color.fromARGB(255, 10, 90, 165),
                fontSize: 16,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Utils.getStockStatus(stock, 18),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
