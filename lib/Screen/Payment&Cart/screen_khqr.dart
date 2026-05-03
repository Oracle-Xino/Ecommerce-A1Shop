import 'package:a1shop/Screen/Payment&Cart/screen_purchase.dart';
import 'package:flutter/material.dart';

class KHQRScreen extends StatefulWidget {
  const KHQRScreen({super.key, this.quantity, this.price});

  final int? quantity;
  final double? price;

  @override
  State<KHQRScreen> createState() => _KHQRScreenState();
}

class _KHQRScreenState extends State<KHQRScreen> {
  List<String> imageUrl = [
    'https://upload.wikimedia.org/wikipedia/commons/b/bb/KHQR_Logo.png',
  ];
  String image1 = 'assets/images/KHQR.png';

  var scaffoldWidget = Scaffold;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        body: Dialog(
          child: InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PurchaseScreen()),
            ),
            child: Container(
              height: 470,
              width: 340,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 30,
                children: [
                  Stack(
                    alignment: AlignmentGeometry.topCenter,
                    children: [
                      const ClipRRect(
                        borderRadius: BorderRadiusGeometry.directional(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20),
                        ),
                        child: ColoredBox(
                          color: Color.fromARGB(255, 255, 18, 1),
                          child: SizedBox(height: 60, width: 340),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        top: 1,
                        child: Image.network(
                          imageUrl.first,
                          fit: BoxFit.contain,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 50,
                    width: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 43,
                          child: Text(
                            'Oracle >⩊<',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 43,
                          top: 20,
                          child: Text(
                            '\$${widget.price?.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: Image.asset(
                      image1,
                      width: 270,
                      height: 270,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Text('Image Error $error'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
