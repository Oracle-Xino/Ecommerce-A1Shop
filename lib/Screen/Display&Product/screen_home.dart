import 'package:a1shop/API/fake_api.dart';
import 'package:a1shop/CustomWidgets/custom_widget.dart';
import 'package:a1shop/Screen/Display&Product/screen_product_type.dart';
import 'package:a1shop/Screen/SEARCH_SCREEN/screen_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(dataProvider);
    final currentDotIndex = ref.watch(zSelectedIndexDotProvider);
    final currentScreenIndex = ref.watch(zSelectedIndexScreenProvider);
    final currentColor = ref.watch(zColorListProvider);
    final currentSearchSelect = ref.watch(zIsSelectedProvider);
    final currentButtonSelect = ref.watch(zIsSelectedButtonProvider);

    return Scaffold(
      appBar: AppBar(
        title: WidgetText(
          firstTitle: mainTitle[0],
          secondTitle: mainTitle.substring(1, 2),
          thirdTitle: mainTitle.substring(3),
        ),
        centerTitle: true,
        actions: [
          //SEARCH BUTTON
          IconButton(
            onPressed: () {
              ref.read(zIsSelectedProvider.notifier).state =
                  !currentSearchSelect;
            },
            icon: currentSearchSelect
                ? Icon(Icons.search_off_outlined)
                : Icon(Icons.search),
          ),

          //ROUTE TO CART
          RouteToCartScreen(),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          //SEARCH BAR
          SliverToBoxAdapter(
            child: currentSearchSelect ? SearchBarScreen() : SizedBox(),
          ),

          //CAROUSEL SLIDER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) => ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.asset(images[index], fit: BoxFit.cover),
                    ),
                    options: CarouselOptions(
                      autoPlay: true,
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        ref.read(zSelectedIndexDotProvider.notifier).state =
                            index;
                      },
                    ),
                  ),

                  //INDICATOR
                  Positioned(
                    top: 45,
                    child: AnimatedSmoothIndicator(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      axisDirection: Axis.vertical,
                      activeIndex: ref.watch(zSelectedIndexDotProvider),
                      count: images.length,
                      effect: WormEffect(
                        activeDotColor: currentColor[currentDotIndex],
                        type: WormType.thinUnderground,
                        dotHeight: 10,
                        dotWidth: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //VIEW ALL BUTTON
          SliverToBoxAdapter(
            child: ViewAll(
              category: 'Categories',
              viewall: currentButtonSelect ? 'Hide' : 'ViewAll',
              onPressed: () {
                ref.read(zIsSelectedButtonProvider.notifier).state =
                    !currentButtonSelect;
              },
            ),
          ),
          //CATEGORY ICONS
          SliverToBoxAdapter(
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    currentButtonSelect ? icons.length : 3,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(8),
                        child: SizedBox(
                          height: 50,
                          width: 130,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: currentScreenIndex == index
                                  ? Colors.amberAccent
                                  : const Color.fromARGB(255, 253, 254, 255),
                            ),
                            onPressed: () {
                              ref
                                      .read(
                                        zSelectedIndexScreenProvider.notifier,
                                      )
                                      .state =
                                  index;
                            },
                            label: Text(categories[index]),
                            icon: icons[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //CATEGORIES SCREEN
          SliverToBoxAdapter(
            child: data.when(
              data: (data) {
                var items = data.products!;

                List<Widget> screens = [
                  ProductTypeScreen(products: items, category: 'all'),
                  ProductTypeScreen(products: items, category: 'beauty'),
                  ProductTypeScreen(products: items, category: 'fragrances'),
                  ProductTypeScreen(products: items, category: 'groceries'),
                  ProductTypeScreen(products: items, category: 'furniture'),
                ];

                return screens[currentScreenIndex];
              },
              error: (error, stackTrack) => Text('Error $error'),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
