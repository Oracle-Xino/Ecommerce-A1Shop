import 'package:a1shop/MODEL/model_cafe.dart';
import 'package:a1shop/Screen/Display&Product/screen_dialog.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final counterNotifierProvider =
    NotifierProvider<CounterNotifier, Map<int, int>>(CounterNotifier.new);

class CounterNotifier extends Notifier<Map<int, int>> {
  @override
  Map<int, int> build() => {};

  void increment(int id, double price) {
    int currentid = state[id] ?? 1;
    state = {...state, id: currentid + 1};
    price * currentid;
  }

  void decrement(int id, double price) {
    int currentid = state[id] ?? 1;
    state = {...state, id: currentid - 1};
    if (currentid <= 1) state = {...state, id: currentid = 1};
    price * currentid;
  }

  void resetQty(int id, double price) {
    final currentid = {...state}..remove(id);
    state = currentid;
  }

  void resetQtyToFirst(int quantity, double price) {
    final currentid = {...state}..clear();
    state = currentid;
  }

  void paidPrice(Product product, double price) {
    final currentid = {...state};
    state = currentid;
  }
}

//To Route
class RouteThisScreen {
  RouteThisScreen({
    required this.context,
    this.title,
    this.image,
    this.price,
    this.quantity,
    this.productid,
    this.product,
  });
  BuildContext context;
  String? title;
  String? image;
  double? price;
  int? quantity;
  int? productid;
  Product? product;

  void toRouteThisDialog() => Navigator.of(context).push(
    DialogRoute(
      context: context,
      builder: (context) => DialogScreen(
        title: title,
        image: image ?? '',
        price: price,
        quantity: quantity,
        productid: productid,
        product: product,
      ),
    ),
  );

  void toPopThisDialog() => Navigator.pop(context);
}
