import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/providers/activescreen_provider.dart';
import 'package:tv_catalog_provider/providers/cartdata_provider.dart';
import 'package:tv_catalog_provider/screens/mobile_detail_screen.dart';
import 'package:tv_catalog_provider/screens/tv_detail_screen.dart';
import 'package:tv_catalog_provider/widgets/cart/empty_cart.dart';
import 'package:tv_catalog_provider/widgets/cart/cart_information.dart';
import 'package:tv_catalog_provider/widgets/cart/item_button_style.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartDataProvider);
    var totalPrice =
        ref.read(cartDataProvider.notifier).calculateTotalDiscountPrice();
    var totalItems =
        ref.read(cartDataProvider.notifier).calculateTotalItemsInCart();

    return Column(
      children: [
        CartInformation(
          totalPrice: totalPrice,
          totalItems: totalItems,
        ),
        const Divider(
          color: Color.fromARGB(255, 190, 190, 190),
          height: 2,
          thickness: 1.8,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: cartData.isEmpty
              ? const EmptyCart()
              : ListView.builder(
                  itemCount: cartData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = cartData[index];

                    return GestureDetector(
                      onTap: () {
                        if (item.isTv) {
                          ref
                              .read(cartWidgetStackProvider.notifier)
                              .pushWidget(TVDetailScreen(tvId: item.oldId));
                        } else {
                          ref.read(cartWidgetStackProvider.notifier).pushWidget(
                              MobileDetailScreen(mobileId: item.oldId));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        margin: const EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 241, 241, 241),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 160,
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Image.network(
                                    item.imageUrl,
                                    colorBlendMode: item.isOutofStock
                                        ? BlendMode.lighten
                                        : null,
                                    color: item.isOutofStock
                                        ? const Color.fromARGB(
                                            154, 255, 255, 255)
                                        : null,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            item.isOutofStock ? 100 : 255,
                                            0,
                                            0,
                                            0,
                                          ),
                                          fontSize: 15,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          // Discount
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 3,
                                              horizontal: 7,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  item.isOutofStock ? 106 : 255,
                                                  217,
                                                  25,
                                                  11),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Text(
                                              '${item.discount.toInt()}% off',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // Deal Of the Day
                                          if (item.dealOfTheDay)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 3,
                                                horizontal: 7,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    137, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              child: Text(
                                                'Deal of the day',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      item.isOutofStock
                                                          ? 106
                                                          : 255,
                                                      217,
                                                      25,
                                                      11),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          // Limited Time deal
                                          if (item.limitedTimeDeal)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 3,
                                                horizontal: 7,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                              child: Text(
                                                'Limited Time Deal',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      item.isOutofStock
                                                          ? 106
                                                          : 255,
                                                      217,
                                                      25,
                                                      11),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Price
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Utils.getFormattedNumber(
                                              Utils.calculateDiscountedPrice(
                                                item.price,
                                                item.discount,
                                              ).toInt(),
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: Color.fromARGB(
                                                item.isOutofStock ? 100 : 255,
                                                0,
                                                0,
                                                0,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'M.R.P.:',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                    item.isOutofStock
                                                        ? 100
                                                        : 255,
                                                    0,
                                                    0,
                                                    0,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                Utils.getFormattedNumber(
                                                    item.price.toInt()),
                                                style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Color.fromARGB(
                                                    item.isOutofStock
                                                        ? 100
                                                        : 255,
                                                    0,
                                                    0,
                                                    0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      // Image
                                      Image.asset(
                                        'assets/prime.png',
                                        height: 20,
                                        colorBlendMode: item.isOutofStock
                                            ? BlendMode.lighten
                                            : null,
                                        color: item.isOutofStock
                                            ? const Color.fromARGB(
                                                154, 255, 255, 255)
                                            : null,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      if (!item.isOutofStock)
                                        Utils.getStockStatus(item.stock, 14),
                                      if (item.isOutofStock)
                                        const Text(
                                          'Out of Stock',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 172, 2, 2),
                                          ),
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Size: ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                item.isOutofStock ? 100 : 255,
                                                0,
                                                0,
                                                0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${item.sizes}${item.isTv ? ' inches' : ''}',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                item.isOutofStock ? 100 : 255,
                                                0,
                                                0,
                                                0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //
                                      Text(
                                        '10 days Replacement by Brand',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              item.isOutofStock ? 100 : 255,
                                              1,
                                              67,
                                              47),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if (!item.isOutofStock)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 160,
                                    height: 40,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 227, 224, 224),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              if (item.quantity > 1) {
                                                ref
                                                    .read(cartDataProvider
                                                        .notifier)
                                                    .changeQuantity(
                                                        item.id, false, 1);
                                              } else {
                                                ref
                                                    .read(cartDataProvider
                                                        .notifier)
                                                    .removeFromCart(item.id);
                                              }
                                            },
                                            icon: item.quantity == 1
                                                ? const Icon(
                                                    Icons.delete_outline)
                                                : const Icon(Icons.remove),
                                          ),
                                        ),
                                        Container(
                                          width: 1.5,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${item.quantity}',
                                            style: const TextStyle(
                                              fontSize: 21,
                                              color: Color.fromARGB(
                                                  255, 0, 121, 95),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          width: 1.5,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 227, 224, 224),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: IconButton(
                                            disabledColor: Colors.grey,
                                            onPressed: (item.quantity >= 10 ||
                                                    item.stock == 1)
                                                ? null
                                                : () {
                                                    ref
                                                        .read(cartDataProvider
                                                            .notifier)
                                                        .changeQuantity(
                                                            item.id, true, 1);
                                                  },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ItemButtonStyle(
                                          label: 'Delete',
                                          onPressButton: () {
                                            ref
                                                .read(cartDataProvider.notifier)
                                                .removeFromCart(item.id);
                                          }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Save For Later
                                      ItemButtonStyle(
                                        label: 'Save for Later',
                                        onPressButton: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
