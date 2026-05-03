import 'package:a1shop/MODEL/model_cafe.dart';
import 'package:a1shop/Riverpod/page_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProductType extends ConsumerWidget {
  const SearchProductType({
    super.key,
    this.product,
    this.title,
    this.price,
    this.id,
    this.quantity,
    this.imageUrl,
  });

  final Product? product;
  final String? title;
  final double? price;
  final int? id;
  final int? quantity;
  final List<String>? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Product> item = product != null ? [product!] : [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: item.isEmpty
          ? Text("empty")
          : GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              physics: BouncingScrollPhysics(),
              itemCount: item.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),

              itemBuilder: (context, index) {
                final currentItem = item[index];

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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      alignment: AlignmentGeometry.topCenter,
                      children: [
                        //second background color
                        Positioned(
                          top: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(
                                    166,
                                    82,
                                    172,
                                    255,
                                  ),
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
                        if (imageUrl != null)
                          Positioned(
                            bottom: 80,
                            child: Image.network(
                              imageUrl!.first,
                              fit: BoxFit.cover,
                              height: 130,
                              width: 130,
                            ),
                          ),
                        //product titles
                        title != null
                            ? Positioned(
                                bottom: 35,
                                child: SizedBox(
                                  width: 148,
                                  child: Center(
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      title!,
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

                        //price tag title
                        if (price != null)
                          Positioned(
                            top: 200,
                            right: 60,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.5),
                                border: Border.all(width: 1.1),
                              ),
                              child: Text(
                                '\$$price',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        //Instock Icon Tag
                        if (quantity != null)
                          Positioned(
                            top: 115,
                            left: 8,
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
                          Text(
                            'Unavailable',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
