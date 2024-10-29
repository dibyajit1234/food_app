import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uem_food/cart_provider.dart';
import 'package:uem_food/pages/cart_page.dart';

class ProductDisplay extends StatefulWidget {
  final String imageUrl;
  final String price;
  final String item;
  const ProductDisplay(
      {super.key,
      required this.imageUrl,
      required this.price,
      required this.item});

  @override
  State<ProductDisplay> createState() => _ProductDisplay();
}

int itemcount = 1;

class _ProductDisplay extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const CartPage();
                }));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
        title: const Center(
          child: Text(
            "Details",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //food image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(widget.imageUrl),
              ),
            ),
            //food title
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.item,
                style: const TextStyle(fontSize: 35),
              ),
            ),
            //item count
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 80,
                width: 130,
                // color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(10, 20),
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.red),
                        onPressed: () {
                          setState(() {
                            itemcount > 1 ? itemcount-- : 0;
                            print(itemcount);
                          });
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "$itemcount",
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(10, 20),
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.red),
                        onPressed: () {
                          setState(() {
                            itemcount++;
                          });
                          print(itemcount);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //add to cart
            Container(
              height: 160,
              width: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 107, 96),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<CartProvider>(context).addProduct({
                            "title": widget.item,
                            "price": widget.price,
                            "imageUrl": widget.imageUrl,
                            "itemcount": itemcount.toString(),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text("Item is added to cart !")));
                        },
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
