import 'package:flutter/material.dart';
import 'package:uem_food/globalvariable.dart';
import 'package:uem_food/product_card.dart';

class ProductList extends StatelessWidget {
  final int index;
  const ProductList({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic>? products = resturants[index]['products'] as List<dynamic>?;
    int? productcount = products?.length;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 2.5,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foodgo and logo
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Foodgo",
                        style: TextStyle(fontFamily: "updock", fontSize: 45),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  )
                ],
              ),
              Center(
                child: Text(
                  "<- ${resturants[index]['canteen']} ->",
                  style: const TextStyle(
                      fontFamily: "order",
                      fontSize: 35,
                      fontWeight: FontWeight.w900),
                ),
              ),
              //gap
              const SizedBox(height: 10),
              // Search bar
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey, offset: Offset(1, 2))
                              ],
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.arrow_back)),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 187, 15, 3),
                          ),
                          hintText: "search",
                          filled: true,
                          border: border,
                          enabledBorder: border,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //gap
              const SizedBox(height: 20),
              // Make the GridView scrollable by using Expanded
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: productcount,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageurl: "${products![index]['imageUrl']}",
                      productName: "${products[index]['title']}",
                      price: products[index]['price'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
