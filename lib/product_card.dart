import 'package:flutter/material.dart';
import 'package:uem_food/pages/product_display.dart';

class ProductCard extends StatelessWidget {
  final String imageurl;
  final String productName;
  final int price;
  const ProductCard({
    super.key,
    required this.productName,
    required this.imageurl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ProductDisplay(imageUrl: imageurl,price: "$price",item: productName,);
        }));
      },
      child: SizedBox(
        height: 300,
        width: 300,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    image: AssetImage(imageurl),
                    width: 90,
                    height: 90,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    productName,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Rs. $price",
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
