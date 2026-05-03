import 'package:a1shop/API/fake_api.dart';
import 'package:a1shop/CustomWidgets/custom_widget.dart';
import 'package:a1shop/Riverpod/page_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProduct extends ConsumerWidget {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider);
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          firstTitle: secondTitle[0],
          secondTitle: secondTitle.substring(1, 3),
          thirdTitle: secondTitle.substring(3),
        ),
        centerTitle: true,
        actions: [RouteToCartScreen()],
      ),
      body: data.when(
        data: (data) => GridView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(8),
          physics: BouncingScrollPhysics(),
          itemCount: data.products?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),

          itemBuilder: (context, index) {
            var item = data.products![index];
            var titles = item.title;
            var images = item.images;
            var price = item.price;
            var stock = item.stock;
            var id = item.id;
            return GestureDetector(
              onTap: () {
                RouteThisScreen route = RouteThisScreen(
                  context: context,
                  title: titles,
                  image: images!.first,
                  price: price,
                  quantity: stock,
                  productid: id,
                  product: item,
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
                    if (images != null)
                      Positioned(
                        bottom: 80,
                        child: Image.network(
                          images.first,
                          fit: BoxFit.cover,
                          height: 130,
                          width: 130,
                        ),
                      ),
                    //product titles
                    titles != null
                        ? Positioned(
                            bottom: 35,
                            child: SizedBox(
                              width: 148,
                              child: Center(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  titles,
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
                    if (stock != null)
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
                      Text('Unavailable', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            );
          },
        ),
        error: (error, stackTrace) => Text('Error Please try again'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
