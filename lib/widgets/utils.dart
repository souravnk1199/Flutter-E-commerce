import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formattedDate() {
    final now = DateTime.now();
    // final random = Random();
    // final dayOffset = random.nextInt(10) + 1; // Random number between 1 and 10

    final modifiedDate = now.add(const Duration(days: 2));

    final dayName = DateFormat('E').format(modifiedDate);
    final date = DateFormat('d').format(modifiedDate);
    final month = DateFormat('MMM').format(modifiedDate);
    final startTime = DateFormat('h:mm a').format(DateTime(
        modifiedDate.year, modifiedDate.month, modifiedDate.day, 11, 0));
    final endTime = DateFormat('h:mm a').format(DateTime(
        modifiedDate.year, modifiedDate.month, modifiedDate.day, 21, 0));

    return '$dayName, $date $month, $startTime - $endTime';
  }

  static Widget getSizeList(List<dynamic> sizes) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: sizes.map((size) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ), // Add horizontal margin
          padding: const EdgeInsets.all(4.0), // Add padding
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(156, 0, 0, 0),
              width: 1.0,
            ), // Add border
            borderRadius: BorderRadius.circular(5.0), // Add border radius
          ),
          // height: 40.0, // Set a fixed height for each size item
          alignment: Alignment.center,
          child: Text(
            '$size"',
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }

  static double calculateDiscountedPrice(double price, double discount) {
    return (price - (price * (discount / 100)));
  }

  static String getFormattedNumber(int num) {
    final indianFormat =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2);
    return indianFormat.format(num);
  }

  static Widget getStockStatus(int stock, double fontSize) {
    late Text textWidget;
    if (stock == 2) {
      textWidget = Text(
        'In stock',
        style: TextStyle(
          color: const Color.fromARGB(255, 12, 107, 30),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (stock == 1) {
      textWidget = Text(
        'Limited stock',
        style: TextStyle(
          color: const Color.fromARGB(255, 236, 138, 58),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      textWidget = Text(
        'Out of stock',
        style: TextStyle(
          color: const Color.fromARGB(255, 172, 2, 2),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return textWidget;
  }

  static String getMobileName({
    required String brand,
    required String name,
    required String longName,
    required String color,
    required String size,
  }) {
    if (brand == 'Apple') {
      return '$name ($size) - $color';
    } else {
      List<String> parts = size.split('+');
      String ramPart = parts[0].trim();
      String storagePart = parts[1].trim();
      return '$name ($color, $ramPart RAM, $storagePart Storage) $longName';
    }
  }
}
