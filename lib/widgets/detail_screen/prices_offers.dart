import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/catalogue/special_offer.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class PricesOffers extends StatelessWidget {
  final bool dealOfTheDay;
  final bool limitedTimeDeal;
  final double price;
  final double discount;
  final String offers;
  const PricesOffers({
    super.key,
    required this.dealOfTheDay,
    required this.limitedTimeDeal,
    required this.price,
    required this.discount,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dealOfTheDay)
            const SpecialOffer(
              text: 'Deal of the Day',
              size: 14,
            ),
          if (limitedTimeDeal)
            const SpecialOffer(
              text: 'Limited Time Deal',
              size: 14,
            ),
          if (dealOfTheDay || limitedTimeDeal)
            const SizedBox(
              height: 10,
            ),
          Row(
            children: [
              Text(
                '-${discount.toInt()}%',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                Utils.getFormattedNumber(
                    Utils.calculateDiscountedPrice(price, discount).toInt()),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "M.R.P.:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                Utils.getFormattedNumber(price.toInt()),
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            "assets/prime.png",
            height: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            offers,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
