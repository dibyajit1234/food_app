import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uem_food/functions/cart_provider.dart';
import 'package:uem_food/pages/home_page.dart';

class ReciptPage extends StatelessWidget {
  final dynamic total;
  final dynamic name;
  final dynamic contact;
  final dynamic building;
  final dynamic room;
  const ReciptPage(
      {super.key,
      required this.total,
      required this.name,
      required this.contact,
      required this.building,
      required this.room});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;

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
        title: const Center(
          child: Text("Receipt"),
        ),
      ),
      body: Center(
        child: Column(children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 214, 231, 245),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "ORDER CONFIRMATION",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$name thank you for your order!!",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Column(
                      children: [
                        Text(
                          "We've received your order. You will receive a receipt",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "in your registered email.",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 183, 183),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "-: Order Summary :-",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contact No : $contact"),
                            Text("Building Name: $building"),
                            Text("Room No : $room")
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "${cart[index]['title']}",
                              ),
                              subtitle: Text(
                                "Quantity : ${cart[index]['itemcount']}",
                              ),
                              trailing: Text(
                                "Price : ${cart[index]['price']}",
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Amount : ",
                            ),
                            Text(
                              "Rs. $total",
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
//.