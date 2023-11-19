import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  final bool favourite;
  final void Function(int) onPressFavourite;
  final int id;
  const FavouriteButton({
    super.key,
    required this.favourite,
    required this.onPressFavourite,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              onPressFavourite(id);
            },
            icon: favourite
                ? const Icon(
                    Icons.favorite,
                    size: 40,
                    color: Color.fromARGB(255, 213, 43, 43),
                  )
                : const Icon(
                    Icons.favorite_outline,
                    size: 40,
                    color: Colors.grey,
                  ),
          ),
        ],
      ),
    );
  }
}
