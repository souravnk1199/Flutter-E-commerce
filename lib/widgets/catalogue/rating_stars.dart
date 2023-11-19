import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int totalRating;
  final double iconSize;
  const RatingStars({
    super.key,
    required this.rating,
    required this.totalRating,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(
              255,
              54,
              145,
              220,
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Row(
          children: List.generate(
            5,
            (index) {
              if (rating >= (index + 1)) {
                return Icon(
                  Icons.star,
                  color: const Color.fromARGB(255, 217, 147, 42),
                  size: iconSize,
                );
              } else if (rating > index && rating < (index + 1)) {
                return Icon(
                  Icons.star_half,
                  color: const Color.fromARGB(255, 217, 147, 42),
                  size: iconSize,
                );
              } else {
                return Icon(
                  Icons.star_border_outlined,
                  color: const Color.fromARGB(255, 217, 147, 42),
                  size: iconSize,
                );
              }
            },
          ),
        ),
        Text('($totalRating)'),
      ],
    );
  }
}
