// import 'package:flutter/material.dart';
// import 'package:uem_food/functions/globalvariable.dart';
// import 'package:uem_food/functions/product_card.dart';
// import 'package:uem_food/pages/cart_page.dart';

// class ProductList extends StatelessWidget {
//   final int index;
//   const ProductList({
//     super.key,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<dynamic>? products = resturants[index]['products'] as List<dynamic>?;
//     final String canteen = resturants[index]['canteen'] as String;
//     int? productcount = products?.length;
//     final border = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30),
//       borderSide: const BorderSide(
//         color: Colors.white,
//         width: 2.5,
//       ),
//     );
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Foodgo and logo
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Foodplaza",
//                         style: TextStyle(fontFamily: "updock", fontSize: 45),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return CartPage();
//                             },
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.shopping_cart))
//                 ],
//               ),
//               Center(
//                 child: Text(
//                   "<- ${resturants[index]['canteen']} ->",
//                   style: const TextStyle(
//                       fontFamily: "order",
//                       fontSize: 35,
//                       fontWeight: FontWeight.w900),
//                 ),
//               ),
//               //gap
//               const SizedBox(height: 10),
//               // Search bar
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                           height: 35,
//                           width: 35,
//                           decoration: BoxDecoration(
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Colors.grey, offset: Offset(1, 2))
//                               ],
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               borderRadius: BorderRadius.circular(15)),
//                           child: const Icon(Icons.arrow_back)),
//                     ),
//                     SizedBox(
//                       width: 300,
//                       child: TextField(
//                         cursorHeight: 20,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.search,
//                             color: Color.fromARGB(255, 187, 15, 3),
//                           ),
//                           hintText: "search",
//                           filled: true,
//                           border: border,
//                           enabledBorder: border,
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               //gap
//               const SizedBox(height: 20),

//               Expanded(
//                 child: GridView.builder(
//                   scrollDirection: Axis.vertical,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                   ),
//                   itemCount: productcount,
//                   itemBuilder: (context, index) {
//                     return ProductCard(
//                       imageurl: "${products![index]['imageUrl']}",
//                       productName: "${products[index]['title']}",
//                       price: products[index]['price'],
//                       canteen: canteen,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:uem_food/functions/globalvariable.dart';
import 'package:uem_food/functions/product_card.dart';
import 'package:uem_food/pages/cart_page.dart';

class ProductList extends StatefulWidget {
  final int index;

  const ProductList({
    super.key,
    required this.index,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<dynamic> products;
  late List<dynamic> filteredProducts;
  final TextEditingController _searchController = TextEditingController();
  late String canteen;

  @override
  void initState() {
    super.initState();
    products = resturants[widget.index]['products'] as List<dynamic>;
    filteredProducts = products;
    canteen = resturants[widget.index]['canteen'] as String;

    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((product) {
        final title = (product['title'] as String).toLowerCase();
        return title.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              // Foodplaza Logo and Cart Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Foodplaza",
                        style: TextStyle(fontFamily: "updock", fontSize: 45),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return CartPage();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "<- $canteen ->",
                  style: const TextStyle(
                    fontFamily: "order",
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Gap

              // Search Bar
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
                            BoxShadow(color: Colors.grey, offset: Offset(1, 2))
                          ],
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _searchController,
                        cursorHeight: 20,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 187, 15, 3),
                          ),
                          hintText: "Search for food",
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
              const SizedBox(height: 20), // Gap

              // Product Grid
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageurl: "${filteredProducts[index]['imageUrl']}",
                      productName: "${filteredProducts[index]['title']}",
                      price: filteredProducts[index]['price'],
                      canteen: canteen,
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
