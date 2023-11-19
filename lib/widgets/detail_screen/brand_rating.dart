import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/catalogue/rating_stars.dart';

class Brandrating extends StatelessWidget {
  final String brand;
  final double rating;
  final int totalRating;

  const Brandrating({
    super.key,
    required this.brand,
    required this.rating,
    required this.totalRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Visit the $brand Store',
          style: const TextStyle(
            color: Color.fromARGB(255, 6, 135, 131),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        RatingStars(
          rating: rating,
          totalRating: totalRating,
          iconSize: 15,
        )
      ],
    );
  }
}
