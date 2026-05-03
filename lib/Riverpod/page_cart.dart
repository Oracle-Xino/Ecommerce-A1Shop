import 'package:a1shop/MODEL/model_cafe.dart' show Product;
import 'package:a1shop/MODEL/model_cart.dart' show CartModel;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = NotifierProvider<CartNotifier, Map<int, CartModel>>(
  CartNotifier.new,
);

class CartNotifier extends Notifier<Map<int, CartModel>> {
  @override
  Map<int, CartModel> build() => {};

  void sendProduct(Product product, int id, {int quantity = 1}) {
    state = {...state, id: CartModel(product: product, quantity: quantity)};
  }

  void increment(Product product, int id, int quantity) {
    state = {...state, id: CartModel(product: product, quantity: quantity + 1)};
  }

  void decrement(Product product, id, int quantity) {
    quantity <= 1
        ? state = {
            ...state,
            id: CartModel(product: product, quantity: quantity = 1),
          }
        : state = {
            ...state,
            id: CartModel(product: product, quantity: quantity - 1),
          };
  }

  void delete(int id) {
    final delete = {...state}..remove(id);
    state = delete;
  }

  void clear() {
    final delete = {...state}..clear();
    state = delete;
  }
}
