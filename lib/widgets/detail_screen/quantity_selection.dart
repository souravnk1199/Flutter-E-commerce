import 'package:flutter/material.dart';

class QuantitySelection extends StatelessWidget {
  final int id;
  final int stock;
  final int quantity;
  final void Function(int, int) onSelectQuantity;
  const QuantitySelection({
    super.key,
    required this.id,
    required this.stock,
    required this.quantity,
    required this.onSelectQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: stock != 1
              ? () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Select Quantity"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(10, (index) {
                            final selectedQuantity = index + 1;
                            return ListTile(
                              title: Center(
                                child: Text(
                                  selectedQuantity.toString(),
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ),
                              onTap: () {
                                onSelectQuantity(id, selectedQuantity);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              selected: selectedQuantity == quantity,
                            );
                          }),
                        ),
                      );
                    },
                  );
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 239, 238, 238),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey, // Shadow color
                  blurRadius: 5.0, // Spread of the shadow
                  offset: Offset(0, 2), // Offset (horizontal, vertical)
                ),
              ],
            ),
            child: Row(children: [
              Text(
                'Qty:',
                style: TextStyle(
                  fontSize: 16,
                  color: stock == 1 ? Colors.grey : Colors.black,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$quantity',
                style: TextStyle(
                  fontSize: 18,
                  color: stock == 1 ? Colors.grey : Colors.black,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: stock == 1 ? Colors.grey : Colors.black,
              )
            ]),
          ),
        )
      ],
    );
  }
}
