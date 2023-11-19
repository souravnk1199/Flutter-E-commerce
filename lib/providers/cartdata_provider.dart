import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tv_catalog_provider/models/cart_model.dart';

class CartDataNotifier extends StateNotifier<List<CartModel>> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  CartDataNotifier(this.scaffoldMessengerKey, super.state);

  bool addToCart(CartModel cartItem, BuildContext context) {
    List<CartModel> temp = List.from(state);
    CartModel existingCartItem = temp.firstWhere(
      (item) => item.id == cartItem.id,
      orElse: () => CartModel(
        id: '',
        oldId: 1,
        name: '',
        imageUrl: '',
        sizes: 0,
        price: 0.0,
        discount: 0.0,
        quantity: 0,
        dealOfTheDay: false,
        limitedTimeDeal: false,
        discountPrice: 0.0,
        stock: 0,
        selectedIndex: 0,
        isTv: false,
      ),
    );

    late bool added;
    late bool limitedStockItemAdded;

    if (cartItem.stock == 2) {
      limitedStockItemAdded = false;
      if (existingCartItem.id == '') {
        temp.add(cartItem);
        added = true;
      } else {
        if (existingCartItem.quantity + cartItem.quantity <= 10) {
          existingCartItem.quantity += cartItem.quantity;
          added = true;
        } else {
          added = false;
        }
      }
    }

    if (cartItem.stock == 1) {
      if (existingCartItem.id == '') {
        if (cartItem.quantity > 1) {
          added = false;
          limitedStockItemAdded = false;
        } else {
          temp.add(cartItem);
          added = true;
          limitedStockItemAdded = true;
        }
      } else {
        added = false;
        limitedStockItemAdded = false;
      }
    }

    state = temp;
    if (limitedStockItemAdded) {
      Future.delayed(Duration(seconds: cartItem.timerDuration), () {
        removeFromStock(cartItem.id);
        // showDeleteMessage(cartItem);
        // removeFromCart(cartItem.id);
      });
    }
    return added;
  }

  void removeFromStock(String id) {
    List<CartModel> temp = [...state];
    CartModel item = temp.firstWhere((e) => e.id == id);
    item.isOutofStock = true;
    state = temp;
    Future.delayed(
      const Duration(seconds: 5),
      () {
        showDeleteMessage(item);
        removeFromCart(id);
      },
    );
  }

  void showDeleteMessage(CartModel cartItem) {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          '${cartItem.name.substring(0, 20)}... removed from Cart.',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
          textColor: const Color.fromARGB(
              255, 22, 231, 234), // Empty callback to dismiss the SnackBar
        ),
        duration: const Duration(seconds: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void removeFromCart(String itemId) {
    List<CartModel> temp = List.from(state);
    temp.removeWhere((item) => item.id == itemId);
    state = temp;
  }

  void changeQuantity(String id, bool add, int quanity) {
    List<CartModel> temp = List.from(state);
    CartModel tempTv = temp.firstWhere((element) => element.id == id);
    if (add) {
      tempTv.quantity += quanity;
    } else {
      tempTv.quantity -= quanity;
    }
    state = temp;
  }

  double calculateTotalDiscountPrice() {
    double totalDiscountPrice = 0.0;
    for (var item in state) {
      if (!item.isOutofStock) {
        totalDiscountPrice += item.discountPrice * item.quantity;
      }
    }
    return totalDiscountPrice;
  }

  int calculateTotalItemsInCart() {
    int totalItems = 0;
    for (var item in state) {
      if (!item.isOutofStock) {
        totalItems += item.quantity;
      }
    }
    return totalItems;
  }
}

final cartDataProvider =
    StateNotifierProvider<CartDataNotifier, List<CartModel>>(
  (ref) {
    final scaffoldMessengerKey = ref.watch(scaffoldMessengerKeyProvider);
    return CartDataNotifier(scaffoldMessengerKey, []);
  },
);

final scaffoldMessengerKeyProvider =
    StateProvider((ref) => GlobalKey<ScaffoldMessengerState>());
