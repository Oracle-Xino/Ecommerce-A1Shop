import 'package:a1shop/API/fake_api.dart';
import 'package:a1shop/Screen/SEARCH_SCREEN/screen_search_product_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarScreen extends ConsumerStatefulWidget {
  const SearchBarScreen({super.key});

  @override
  ConsumerState<SearchBarScreen> createState() => _SearchBarScreen();
}

class _SearchBarScreen extends ConsumerState<SearchBarScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ref.watch(dataProvider);
    return SearchAnchor(
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          autoFocus: false,
          hintText: 'Search',
          onTap: () {},
          onChanged: (value) {
            controller.openView();
          },
        );
      },
      suggestionsBuilder: (context, controller) {
        return data.when(
          data: (data) {
            var items = data.products!
                .where(
                  (item) => item.title!.toLowerCase().contains(
                    controller.text.toLowerCase(),
                  ),
                )
                .toList();
            return items.map(
              (item) => ListTile(
                title: Text(item.title ?? ''),
                onTap: () => Navigator.push(
                  context,
                  DialogRoute(
                    context: context,
                    builder: (context) => SearchProductType(
                      title: item.title,
                      id: item.id,
                      price: item.price,
                      quantity: item.stock,
                      imageUrl: item.images,
                      product: item,
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => [
            Text('$error is wrong, please try again!'),
          ],
          loading: () => [Center(child: CircularProgressIndicator())],
        );
      },
    );
  }
}
