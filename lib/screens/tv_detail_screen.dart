import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/models/cart_model.dart';
import 'package:tv_catalog_provider/models/tv_model.dart';
import 'package:tv_catalog_provider/providers/cartdata_provider.dart';
import 'package:tv_catalog_provider/providers/tvdata_provider.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/amzon_choice.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/big_button.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/brand_rating.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/cart_confirmation.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/currently_unavailable.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/delivery_information.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/discount_share.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/favourite_button.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/prices_offers.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/quantity_selection.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/seller_details.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/size_list.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/view_buttons.dart';
import 'package:tv_catalog_provider/widgets/product_image_carousel.dart';

class TVDetailScreen extends ConsumerStatefulWidget {
  final int tvId;

  const TVDetailScreen({
    super.key,
    required this.tvId,
  });

  @override
  ConsumerState<TVDetailScreen> createState() {
    return _TVDetailScreenState();
  }
}

class _TVDetailScreenState extends ConsumerState<TVDetailScreen> {
  late bool added;
  late CartModel cartItem;

  void onPressFavourite(int id) {
    ref.read(favouriteTvProvider.notifier).toggleFavourite(id);
  }

  void onToggleSize(int id) {
    ref.read(showTvSizesProvider.notifier).toggleShowsize(id);
  }

  void onSelectSizeIndex(int id, int index) {
    ref.read(selectedTvQuantityProvider.notifier).changeQuantity(id, 1);
    ref.read(selectedTvSizeIndexProvider.notifier).changeIndex(id, index);
  }

  void onSelectQuantity(int id, int num) {
    ref.read(selectedTvQuantityProvider.notifier).changeQuantity(id, num);
  }

  void onPressAddToCart(TVModel tv, int quantity, int index) {
    cartItem = CartModel.fromTVModel(
      tv: tv,
      quantity: quantity,
      index: index,
    );
    added = ref.read(cartDataProvider.notifier).addToCart(
          cartItem,
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final tvList = ref.watch(tvDataProvider);
    final tv = tvList.firstWhere((element) => element.id == widget.tvId);
    final selectedIndex = ref.watch(selectedTvSizeIndexProvider)[tv.id - 1];
    final favourite = ref.watch(favouriteTvProvider)[tv.id - 1];
    final showSizes = ref.watch(showTvSizesProvider)[tv.id - 1];
    final quantity = ref.watch(selectedTvQuantityProvider)[tv.id - 1];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiscountShare(
                  stock: tv.stock[selectedIndex],
                  discount: tv.discount[selectedIndex],
                ),
                ImageCarousel(imageUrls: tv.imageUrls),
                FavouriteButton(
                  favourite: favourite,
                  onPressFavourite: onPressFavourite,
                  id: tv.id,
                ),
                const SizedBox(height: 5),
                Brandrating(
                  brand: tv.brand,
                  rating: tv.rating,
                  totalRating: tv.totalRating,
                ),
                const SizedBox(height: 5),
                Text(tv.name),
                const SizedBox(height: 5),
                const AmazonChoice(),
                const ViewButtons(),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 3,
            color: Color.fromARGB(255, 202, 202, 202),
          ),
          SizeList(
            id: tv.id,
            isTv: true,
            sizes: tv.sizes,
            stocks: tv.stock,
            prices: tv.price,
            selectedIndex: selectedIndex,
            showSizes: showSizes,
            onToggleSize: onToggleSize,
            onSelectSizeIndex: onSelectSizeIndex,
          ),
          const Divider(
            height: 1,
            thickness: 3,
            color: Color.fromARGB(255, 202, 202, 202),
          ),
          if (tv.stock[selectedIndex] != 0)
            PricesOffers(
              dealOfTheDay: tv.dealOfTheDay,
              limitedTimeDeal: tv.limitedTimeDeal,
              price: tv.price[selectedIndex],
              discount: tv.discount[selectedIndex],
              offers: tv.offers,
            ),
          if (tv.stock[selectedIndex] == 0) const CurrentlyUnAvailable(),
          const Divider(
            height: 1,
            thickness: 3,
            color: Color.fromARGB(255, 202, 202, 202),
          ),
          if (tv.stock[selectedIndex] != 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryInformation(stock: tv.stock[selectedIndex]),
                  QuantitySelection(
                    id: tv.id,
                    stock: tv.stock[selectedIndex],
                    quantity: quantity,
                    onSelectQuantity: onSelectQuantity,
                  ),
                  const SizedBox(height: 15),
                  BigButton(
                    color: const Color.fromARGB(255, 224, 195, 27),
                    text: "Add to Cart",
                    onPressButton: () {
                      onPressAddToCart(tv, quantity, selectedIndex);
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CartConfirmation(
                            added: added,
                            imageUrl: tv.imageUrls[0],
                            stock: tv.stock[selectedIndex],
                            cartItem: cartItem,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  BigButton(
                    color: const Color.fromARGB(255, 215, 148, 1),
                    text: "Buy Now",
                    onPressButton: () {},
                  ),
                  const SizedBox(height: 10),
                  SellerDetails(seller: tv.seller),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          // Add more details as needed
        ],
      ),
    );
  }
}
