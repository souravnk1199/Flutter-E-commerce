import 'package:flutter/material.dart';

class ItemName extends StatelessWidget {
  final String name;

  const ItemName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
