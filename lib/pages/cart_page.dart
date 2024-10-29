import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uem_food/cart_provider.dart';
import 'package:uem_food/pages/product_display.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Center(child: Text("Cart")),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${cart[index]['title']}"),
              subtitle: Text(
                  "Rs. ${cart[index]['price']}      Item Count : ${cart[index][itemcount]}"),
              leading: CircleAvatar(
                backgroundImage: AssetImage(cart[index]['imageUrl']),
                backgroundColor: Colors.red,
              ),
              trailing: IconButton(
                onPressed: () {
                  // Provider.of<CartProvider>(context).removeProduct(cart[index]);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Remove"),
                          content: const Text("Remove this item from cart ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Provider.of<CartProvider>(context)
                                      .removeProduct(cart[index]);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No"))
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            );
          }),
    );
  }
}
