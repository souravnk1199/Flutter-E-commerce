import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/models/cart_model.dart';
import 'package:tv_catalog_provider/providers/activescreen_provider.dart';
import 'package:tv_catalog_provider/providers/cartdata_provider.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class CartConfirmation extends ConsumerWidget {
  final bool added;
  final String imageUrl;
  final int stock;
  final CartModel cartItem;
  const CartConfirmation({
    super.key,
    required this.added,
    required this.imageUrl,
    required this.stock,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Image.network(
                  imageUrl,
                  height: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        added
                            ? Icons.add_shopping_cart
                            : Icons.remove_shopping_cart,
                        color: added
                            ? stock == 1
                                ? const Color.fromARGB(255, 185, 127, 2)
                                : const Color.fromARGB(255, 41, 155, 45)
                            : Colors.red,
                        size: 35,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        added
                            ? stock == 1
                                ? 'Added to Cart. Limited Stock. \nBuy Within ${cartItem.timerDuration} Seconds'
                                : 'Added to cart'
                            : stock == 1
                                ? 'Limited Stock can\'t add \nmore than 1 item'
                                : 'Can\'t add more than 10 items',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: added
                              ? stock == 1
                                  ? const Color.fromARGB(255, 185, 127, 2)
                                  : const Color.fromARGB(255, 41, 155, 45)
                              : Colors.red,
                          fontSize: 15,
                        ),
                      ),
                      // Expanded(child: Container()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          'Cart Subtotal (${ref.read(cartDataProvider.notifier).calculateTotalItemsInCart()} item${ref.read(cartDataProvider.notifier).calculateTotalItemsInCart() > 1 ? 's' : ''}):'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        Utils.getFormattedNumber(ref
                            .read(cartDataProvider.notifier)
                            .calculateTotalDiscountPrice()
                            .toInt()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (ref.watch(navigationBarProvider) == 3) {
                    ref.read(cartWidgetStackProvider.notifier).popWidget();
                  } else {
                    ref.read(cartWidgetStackProvider.notifier).popWidget();
                    ref.read(navigationBarProvider.notifier).state = 3;
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 40,
                    ), // Apply vertical padding
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white,
                  ), // Background color
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                ),
                child: const Text(
                  'Cart',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
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
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
