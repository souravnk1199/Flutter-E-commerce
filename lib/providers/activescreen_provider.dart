import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationBarProvider = StateProvider<int>((ref) => 0);

class HomeWidgetStackNotifier extends StateNotifier<List<Widget>> {
  HomeWidgetStackNotifier(super.state);

  void pushWidget(Widget newWidget) {
    List<Widget> temp = [...state];
    temp.add(newWidget);
    state = temp;
  }

  void popWidget() {
    if (state.isEmpty) {
      return;
    }
    List<Widget> temp = [...state];
    temp.removeLast();
    state = temp;
  }
}

final homeWidgetStackProvider =
    StateNotifierProvider<HomeWidgetStackNotifier, List<Widget>>(
        (ref) => HomeWidgetStackNotifier([]));

class CartWidgetStackNotifier extends StateNotifier<List<Widget>> {
  CartWidgetStackNotifier(super.state);

  void pushWidget(Widget newWidget) {
    List<Widget> temp = [...state];
    temp.add(newWidget);
    state = temp;
  }

  void popWidget() {
    if (state.isEmpty) {
      return;
    }
    List<Widget> temp = [...state];
    temp.removeLast();
    state = temp;
  }
}

final cartWidgetStackProvider =
    StateNotifierProvider<CartWidgetStackNotifier, List<Widget>>(
        (ref) => CartWidgetStackNotifier([]));
