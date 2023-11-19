import 'package:flutter/material.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class CartInformation extends StatefulWidget {
  final double totalPrice;
  final int totalItems;

  const CartInformation({
    super.key,
    required this.totalPrice,
    required this.totalItems,
  });

  @override
  State<CartInformation> createState() => _CartInformationState();
}

class _CartInformationState extends State<CartInformation> {
  var isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 7.5),
          child: Row(
            children: [
              const Text(
                'Subtotal ',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                Utils.getFormattedNumber(widget.totalPrice.toInt()),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )
            ],
          ),
        ),
        // EMI
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 7.5),
          child: const Row(
            children: [
              Text(
                'EMI Available',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 0, 121, 95),
                ),
              ),
            ],
          ),
        ),
        // Proceed To buy
        Container(
          margin: const EdgeInsets.fromLTRB(10, 15, 10, 7.5),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 12,
                      ), // Apply vertical padding
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 255, 196, 33),
                    ), // Background color
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Border radius
                    )),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color:
                            Color.fromARGB(255, 227, 172, 23), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                  ),
                  child: Text(
                    'Proceed to Buy (${widget.totalItems} item${widget.totalItems > 1 ? 's' : ''})',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Send as gift
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? newValue) {
                  setState(
                    () {
                      isChecked = newValue ?? false;
                    },
                  );
                },
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Send as a gift. Include custom message',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
