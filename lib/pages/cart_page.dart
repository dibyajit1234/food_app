import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uem_food/functions/cart_provider.dart';
import 'package:uem_food/pages/home_page.dart';
import 'package:uem_food/pages/payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true).cart;
    final totalprice = cart.fold(
      0,
      (sum, item) {
        final price = int.tryParse(item['price']) ?? 0;
        final itemCount = item['itemcount'] as int;
        return sum + (price * itemCount);
      },
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              },
              icon: const Icon(Icons.home))
        ],
        title: const Center(child: Text("Cart")),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${cart[index]['title']}"),
                    subtitle: Text(
                        "Rs. ${cart[index]['price']}                       Quantity : ${cart[index]['itemcount']}"),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(cart[index]['imageUrl']),
                      backgroundColor: Colors.red,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Remove",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content:
                                  const Text("Remove this item from cart ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Provider.of<CartProvider>(context)
                                          .removeProduct(cart[index]);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "No",
                                      style: TextStyle(color: Colors.green),
                                    ))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  );
                }),
          ),
          Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 243, 243, 243)),
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        const Text(
                          "Total Price :",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs. $totalprice",
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      totalprice != 0
                          ? Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                              return PaymentPage(
                                totalprice: totalprice,
                              );
                            }))
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Warning",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  content: const Text(
                                      "Add some products to cart first!!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Ok"))
                                  ],
                                );
                              });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromARGB(255, 255, 107, 96),
                      fixedSize: const Size(150, 40),
                    ),
                    child: const Text(
                      "Order Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
