import 'package:tv_catalog_provider/models/mobile_model.dart';
import 'package:tv_catalog_provider/models/tv_model.dart';
import 'package:tv_catalog_provider/widgets/utils.dart';

class CartModel {
  final String id; // Unique identifier for the item
  final int oldId;
  final String name;
  final String imageUrl;
  final dynamic sizes;
  final double price;
  final double discount;
  final bool dealOfTheDay;
  final bool limitedTimeDeal;
  final double discountPrice;
  final int stock;
  final int selectedIndex;
  final bool isTv;
  int quantity;
  int timerDuration;
  bool isOutofStock;

  CartModel({
    required this.id,
    required this.oldId,
    required this.name,
    required this.imageUrl,
    required this.sizes,
    required this.price,
    required this.discount,
    required this.dealOfTheDay,
    required this.limitedTimeDeal,
    required this.discountPrice,
    required this.stock,
    required this.selectedIndex,
    required this.isTv,
    required this.quantity,
    this.timerDuration = 20,
    this.isOutofStock = false,
  });

  factory CartModel.fromTVModel({
    required TVModel tv,
    required int quantity,
    required int index,
  }) {
    // Calculate the id based on the combination of name and sizes
    final id = '${tv.name}_${tv.sizes[index]}';

    return CartModel(
      id: id,
      oldId: tv.id,
      name: tv.name,
      imageUrl: tv.imageUrls[0],
      sizes: tv.sizes[index],
      price: tv.price[index],
      discount: tv.discount[index],
      quantity: quantity,
      dealOfTheDay: tv.dealOfTheDay,
      limitedTimeDeal: tv.limitedTimeDeal,
      selectedIndex: index,
      discountPrice: Utils.calculateDiscountedPrice(
        tv.price[index],
        tv.discount[index],
      ),
      stock: tv.stock[index],
      isTv: true,
    );
  }

  factory CartModel.fromMobileModel({
    required MobileModel mobile,
    required int quantity,
    required int sizeIndex,
    required int colorIndex,
  }) {
    final id = '${Utils.getMobileName(
      brand: mobile.brand,
      name: mobile.name,
      longName: mobile.longName,
      color: mobile.color[colorIndex],
      size: mobile.sizes[sizeIndex],
    )}_${mobile.color}_${mobile.sizes[sizeIndex]}';
    return CartModel(
      id: id,
      oldId: mobile.id,
      name: Utils.getMobileName(
        brand: mobile.brand,
        name: mobile.name,
        longName: mobile.longName,
        color: mobile.color[colorIndex],
        size: mobile.sizes[sizeIndex],
      ),
      quantity: quantity,
      imageUrl: mobile.imageUrls[mobile.color[colorIndex]]![0],
      sizes: mobile.sizes[sizeIndex],
      price: mobile.price[sizeIndex],
      discount: mobile.discount[sizeIndex],
      dealOfTheDay: mobile.dealOfTheDay,
      limitedTimeDeal: mobile.limitedTimeDeal,
      discountPrice: Utils.calculateDiscountedPrice(
        mobile.price[sizeIndex],
        mobile.discount[sizeIndex],
      ),
      stock: mobile.stock[sizeIndex],
      selectedIndex: sizeIndex,
      isTv: false,
    );
  }
}
