import 'package:a1shop/MODEL/model_cafe.dart';
import 'package:a1shop/Riverpod/page_cart.dart';
import 'package:a1shop/Riverpod/page_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogScreen extends ConsumerWidget {
  const DialogScreen({
    super.key,
    this.title,
    required this.image,
    this.price,
    this.quantity,
    this.productid,
    required this.product,
  });
  final String image;
  final String? title;
  final double? price;
  final int? quantity;
  final int? productid;
  final Product? product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(counterNotifierProvider)[productid];
    var route = RouteThisScreen(context: context);

    int notifierUpdate = ref.watch(
      counterNotifierProvider.select((map) => map[productid] ?? 1),
    );

    var total = price! * notifierUpdate;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => route.toPopThisDialog(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Dialog(
                backgroundColor: Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ).withAlpha(200),
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(12),
                  height: 500,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //title tag
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          title ?? '',
                          textAlign: TextAlign.values[2],
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //product quantity
                          Text(
                            '$notifierUpdate',
                            style: TextStyle(fontSize: 15),
                          ),

                          //symbol
                          Text(' / ', style: TextStyle(fontSize: 22)),
                          if (price != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 0.3,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.2,
                                ),
                              ),

                              // price tag
                              child: Text(
                                price != null && notifierUpdate != 0
                                    ? '\$${total.toStringAsFixed(2)} '
                                    : 'Unavailable',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      image.isEmpty
                          ? Icon(Icons.error_outline)
                          : Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.brown.withAlpha(70),
                                borderRadius: BorderRadius.circular(8.8),
                              ),
                              child: Image.network(image, fit: BoxFit.contain),
                            ),
                      const SizedBox(height: 10),

                      //add/remove product quantity
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          spacing: 35,
                          children: [
                            Container(
                              height: 40,
                              width: 85,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(150),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: IconButton(
                                  onLongPress: () => ref
                                      .read(counterNotifierProvider.notifier)
                                      .resetQty(productid ?? 1, price ?? 0),
                                  onPressed: () => ref
                                      .read(counterNotifierProvider.notifier)
                                      .decrement(productid ?? 1, price ?? 0),
                                  icon: Icon(Icons.exposure_minus_1),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 85,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(150),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () => ref
                                    .read(counterNotifierProvider.notifier)
                                    .increment(productid ?? 1, price ?? 0),
                                icon: Icon(Icons.exposure_plus_1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      //Add Cart
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(cartProvider.notifier)
                              .sendProduct(
                                product ?? product!,
                                productid ?? 0,
                                quantity: qty ?? 1,
                              );
                          route.toPopThisDialog();
                          ref
                              .read(counterNotifierProvider.notifier)
                              .resetQty(productid!, total);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: Size(240, 60),
                        ),
                        child: Text(
                          'Add Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
