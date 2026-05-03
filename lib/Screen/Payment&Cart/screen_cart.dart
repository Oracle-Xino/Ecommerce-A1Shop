import 'package:a1shop/MODEL/model_cart.dart';
import 'package:a1shop/Riverpod/page_cart.dart';
import 'package:a1shop/Screen/Payment&Cart/screen_khqr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    var item = cart.values.toList();

    double totalQuantityPrice = item.fold<double>(
      0,
      (price, item) =>
          price + ((item.product!.price ?? 0) * item.quantity!.toInt()),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'Item Bag',
          style: TextStyle(fontFamily: 'Infected', fontSize: 35),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: item.isEmpty
          ? Center(child: Text('Cart is empty', style: TextStyle(fontSize: 22)))
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemExtent: 100,
              itemCount: item.length,
              itemBuilder: (context, index) {
                CartModel model = item[index];
                var items = model.product!;
                var quantity = model.quantity!;
                String title = items.title ?? '';
                String imageUrl = items.images!.first;
                double price = items.price ?? 0;
                int id = items.id!;

                var proceedingPrice = price * quantity;

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 20),
                  margin: EdgeInsets.all(6),

                  child: ListTile(
                    leading: imageUrl.isEmpty
                        ? Icon(Icons.image_not_supported_outlined)
                        : Image.network(imageUrl),
                    title: Text(
                      title,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Text('\$${proceedingPrice.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => ref
                              .read(cartProvider.notifier)
                              .decrement(items, id, quantity),
                          icon: quantity == 1
                              ? Icon(
                                  Icons.remove,
                                  color: Color.fromARGB(82, 46, 46, 46),
                                )
                              : Icon(Icons.remove),
                        ),
                        Text('$quantity'),
                        IconButton(
                          onPressed: () => ref
                              .read(cartProvider.notifier)
                              .increment(items, id, quantity),
                          icon: Icon(Icons.add),
                        ),
                        IconButton(
                          onPressed: () =>
                              ref.read(cartProvider.notifier).delete(id),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
        width: 80,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.blueGrey.withAlpha(60),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total:', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Text(
                  '\$${totalQuantityPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 80),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 120, 255),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            KHQRScreen(price: totalQuantityPrice),
                      ),
                    );
                    ref.read(cartProvider.notifier).clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
