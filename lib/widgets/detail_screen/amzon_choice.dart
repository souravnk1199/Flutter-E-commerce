import 'package:flutter/material.dart';

class AmazonChoice extends StatelessWidget {
  const AmazonChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 31, 5, 55),
            ),
            child: const Row(
              children: [
                Text(
                  'Amazon\'s',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Choice',
                  style: TextStyle(
                    color: Color.fromARGB(255, 223, 160, 67),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
