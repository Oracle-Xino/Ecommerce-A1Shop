import 'package:a1shop/MODEL/model_cafe.dart';
import 'package:a1shop/Riverpod/page_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductTypeScreen extends ConsumerWidget {
  const ProductTypeScreen({
    super.key,
    required this.products,
    required this.category,
    this.quantity,
  });

  final List<Product> products;
  final String category;
  final int? quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = category == 'all'
        ? products
        : products
              .where(
                (product) => product.category?.name.toLowerCase() == category,
              )
              .toList();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),

      itemBuilder: (context, index) {
        final currentItem = items[index];

        return GestureDetector(
          onTap: () {
            RouteThisScreen route = RouteThisScreen(
              context: context,
              title: currentItem.title,
              image: currentItem.images!.first,
              price: currentItem.price,
              quantity: quantity,
              productid: currentItem.id,
              product: currentItem,
            );
            return route.toRouteThisDialog();
          },

          //first background color
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: AlignmentGeometry.topCenter,
              children: [
                //second background color
                Positioned(
                  top: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(166, 82, 172, 255),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topCenter,
                        colors: [
                          const Color.fromARGB(252, 255, 108, 176),
                          const Color.fromARGB(185, 113, 198, 255),
                          const Color.fromARGB(176, 100, 65, 255),
                        ],
                      ),
                    ),
                    height: 100,
                    width: 160,
                  ),
                ),
                //image display
                if (currentItem.images != null)
                  Positioned(
                    bottom: 80,
                    child: Image.network(
                      currentItem.images!.first,
                      fit: BoxFit.cover,
                      height: 130,
                      width: 130,
                    ),
                  ),
                //product titles
                currentItem.title != null
                    ? Positioned(
                        top: 80,
                        bottom: 1,
                        child: SizedBox(
                          width: 148,
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              currentItem.title!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text('Error'),

                //price tag
                if (currentItem.price != null)
                  Positioned(
                    top: 170,
                    right: 60,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.5),
                        border: Border.all(width: 1.1),
                      ),
                      child: Text(
                        '\$${currentItem.price}',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                //Instock Icon Tag
                if (currentItem.stock != null && currentItem.stock! > 0)
                  Positioned(
                    top: 105,
                    left: 1,
                    child: Container(
                      color: Colors.black.withAlpha(30),

                      child: Text(
                        'Instock',
                        style: TextStyle(
                          fontSize: 8.9,
                          color: const Color.fromARGB(237, 11, 184, 17),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  )
                else
                  Text('Unavailable', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        );
      },
    );
  }
}
