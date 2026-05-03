import 'package:a1shop/Screen/Payment&Cart/screen_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final zIsSelectedProvider = StateProvider((_) => false);
final zIsSelectedButtonProvider = StateProvider((_) => false);
final zSelectedIndexScreenProvider = StateProvider((_) => 0);
final zSelectedIndexDotProvider = StateProvider((_) => 0);
final zIconsProvider = Provider((_) => icons);
final zColorListProvider = Provider((_) => colors);

const String mainTitle = 'A1 Shop';
const String secondTitle = 'All Product';
const List<String> images = [
  'assets/images/poster1.png',
  'assets/images/poster2.jpg',
  'assets/images/poster3.jpg',
  'assets/images/poster4.jpg',
];
const List<String> categories = [
  'All',
  'Beauty',
  'Fragrances',
  'Groceries',
  'Furniture',
];
const List<Icon> icons = [
  Icon(Icons.clear_all_outlined),
  Icon(Icons.sanitizer_outlined),
  Icon(Icons.brush_outlined),
  Icon(Icons.shopping_basket_outlined),
  Icon(Icons.table_bar_outlined),
];
const List<Color> colors = [
  Color.fromARGB(255, 60, 208, 253),
  Color.fromARGB(255, 243, 224, 54),
  Color.fromARGB(255, 83, 101, 110),
  Color.fromARGB(255, 0, 132, 194),
];

class WidgetText extends StatelessWidget {
  const WidgetText({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.thirdTitle,
  });
  final String firstTitle;
  final String secondTitle;
  final String thirdTitle;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: const TextStyle(fontSize: 40, fontFamily: 'Toony'),
      TextSpan(
        text: firstTitle,
        children: [
          TextSpan(
            text: secondTitle,
            style: const TextStyle(fontFamily: 'Coffee'),
          ),
          TextSpan(text: thirdTitle),
        ],
      ),
    );
  }
}

//ALL Products View
class ViewAll extends StatelessWidget {
  const ViewAll({
    super.key,
    required this.category,
    required this.viewall,
    this.width,
    required this.onPressed,
    this.isSelected,
  });

  final String category;
  final String viewall;
  final double? width;
  final void Function()? onPressed;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                category,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: width ?? 120),
              TextButton(onPressed: onPressed, child: Text(viewall)),
            ],
          ),
          isSelected == true ? Icon(Icons.keyboard_arrow_right) : SizedBox(),
        ],
      ),
    );
  }
}

//Route
class RouteToCartScreen extends StatelessWidget {
  const RouteToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreen()),
      ),
      icon: Icon(Icons.shopping_bag_outlined),
    );
  }
}
