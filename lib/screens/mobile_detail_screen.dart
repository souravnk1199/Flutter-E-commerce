import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/models/cart_model.dart';
import 'package:tv_catalog_provider/models/mobile_model.dart';
import 'package:tv_catalog_provider/providers/cartdata_provider.dart';
import 'package:tv_catalog_provider/providers/mobiledata_provider.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/amzon_choice.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/big_button.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/brand_rating.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/cart_confirmation.dart';
import 'package:tv_catalog_provider/widgets/detail_screen/color_list.dart';
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
import 'package:tv_catalog_provider/widgets/utils.dart';

class MobileDetailScreen extends ConsumerStatefulWidget {
  final int mobileId;

  const MobileDetailScreen({
    super.key,
    required this.mobileId,
  });

  @override
  ConsumerState<MobileDetailScreen> createState() {
    return _MobileDetailScreenState();
  }
}

class _MobileDetailScreenState extends ConsumerState<MobileDetailScreen> {
  late bool added;
  late CartModel cartItem;

  void onPressFavourite(int id) {
    ref.read(favouriteMobileProvider.notifier).toggleFavourite(id);
  }

  void onToggleSize(int id) {
    ref.read(showMobileSizesProvider.notifier).toggleShowsize(id);
  }

  void onSelectSizeIndex(int id, int index) {
    ref.read(selectedMobileQuantityProvider.notifier).changeQuantity(id, 1);
    ref.read(selectedMobileSizeIndexProvider.notifier).changeIndex(id, index);
  }

  void onSelectQuantity(int id, int num) {
    ref.read(selectedMobileQuantityProvider.notifier).changeQuantity(id, num);
  }

  void onToggleColor(int id) {
    ref.read(showMobileColorsProvider.notifier).toggleShowColor(id);
  }

  void onSelectColorIndex(int id, int index) {
    ref.read(selectedMobileColorIndexProvider.notifier).changeIndex(id, index);
  }

  void onPressAddToCart(
    MobileModel mobile,
    int quantity,
    int sizeIndex,
    int colorIndex,
  ) {
    cartItem = CartModel.fromMobileModel(
      mobile: mobile,
      quantity: quantity,
      sizeIndex: sizeIndex,
      colorIndex: colorIndex,
    );
    added = ref.read(cartDataProvider.notifier).addToCart(
          cartItem,
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final mobileList = ref.watch(mobileDataProvider);
    final mobile = mobileList.firstWhere((e) => e.id == widget.mobileId);
    final selectedSizeIndex =
        ref.watch(selectedMobileSizeIndexProvider)[mobile.id - 1];
    final selectedColorIndex =
        ref.watch(selectedMobileColorIndexProvider)[mobile.id - 1];
    final favourite = ref.watch(favouriteMobileProvider)[mobile.id - 1];
    final showSizes = ref.watch(showMobileSizesProvider)[mobile.id - 1];
    final showColors = ref.watch(showMobileColorsProvider)[mobile.id - 1];
    final selectedQuantity =
        ref.watch(selectedMobileQuantityProvider)[mobile.id - 1];

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
                  stock: mobile.stock[selectedSizeIndex],
                  discount: mobile.discount[selectedSizeIndex],
                ),
                ImageCarousel(
                    imageUrls:
                        mobile.imageUrls[mobile.color[selectedColorIndex]]!),
                FavouriteButton(
                  favourite: favourite,
                  onPressFavourite: onPressFavourite,
                  id: mobile.id,
                ),
                const SizedBox(height: 5),
                Brandrating(
                  brand: mobile.brand,
                  rating: mobile.rating,
                  totalRating: mobile.totalRating,
                ),
                const SizedBox(height: 5),
                Text(
                  Utils.getMobileName(
                    brand: mobile.brand,
                    name: mobile.name,
                    longName: mobile.longName,
                    color: mobile.color[selectedColorIndex],
                    size: mobile.sizes[selectedSizeIndex],
                  ),
                ),
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
          ColorList(
            id: mobile.id,
            imageUrls: mobile.imageUrls,
            colors: mobile.color,
            showColors: showColors,
            selectedColorIndex: selectedColorIndex,
            onToggleColor: onToggleColor,
            onSelectColorIndex: onSelectColorIndex,
          ),
          const Divider(
            height: 1,
            thickness: 3,
            color: Color.fromARGB(255, 202, 202, 202),
          ),
          SizeList(
            id: mobile.id,
            isTv: false,
            sizes: mobile.sizes,
            stocks: mobile.stock,
            prices: mobile.price,
            selectedIndex: selectedSizeIndex,
            showSizes: showSizes,
            onToggleSize: onToggleSize,
            onSelectSizeIndex: onSelectSizeIndex,
          ),
          const Divider(
            height: 1,
            thickness: 3,
            color: Color.fromARGB(255, 202, 202, 202),
          ),
          if (mobile.stock[selectedSizeIndex] != 0)
            PricesOffers(
              dealOfTheDay: mobile.dealOfTheDay,
              limitedTimeDeal: mobile.limitedTimeDeal,
              price: mobile.price[selectedSizeIndex],
              discount: mobile.discount[selectedSizeIndex],
              offers: mobile.offers,
            ),
          if (mobile.stock[selectedSizeIndex] == 0)
            const CurrentlyUnAvailable(),
          const Divider(
            height: 1,
            thickness: 3,
            color: Color.fromARGB(255, 202, 202, 202),
          ),
          if (mobile.stock[selectedSizeIndex] != 0)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryInformation(stock: mobile.stock[selectedSizeIndex]),
                  QuantitySelection(
                    id: mobile.id,
                    stock: mobile.stock[selectedSizeIndex],
                    quantity: selectedQuantity,
                    onSelectQuantity: onSelectQuantity,
                  ),
                  const SizedBox(height: 15),
                  BigButton(
                    color: const Color.fromARGB(255, 224, 195, 27),
                    text: "Add to Cart",
                    onPressButton: () {
                      onPressAddToCart(mobile, selectedQuantity,
                          selectedSizeIndex, selectedColorIndex);
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CartConfirmation(
                            added: added,
                            imageUrl: mobile.imageUrls[
                                mobile.color[selectedColorIndex]]![0],
                            stock: mobile.stock[selectedSizeIndex],
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
                  SellerDetails(seller: mobile.seller),
                  const SizedBox(height: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
