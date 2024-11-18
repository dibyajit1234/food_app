import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uem_food/functions/auth_service.dart';
import 'package:uem_food/functions/globalvariable.dart';
import 'package:uem_food/pages/cart_page.dart';
import 'package:uem_food/pages/login_page.dart';
import 'package:uem_food/pages/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("user");
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Center(
            child: Text(
              "Snacky Panda",
              style: TextStyle(fontFamily: "updock", fontSize: 45),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const CartPage();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                height: 70,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Center(
                    child: Text(
                      "Menu",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Signout",
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "Do you want to Signout ?",
                            style: TextStyle(fontSize: 15),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  auth.signout();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const LoginPage();
                                  }));
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
                      });
                },
              )
            ],
          ),
        ),
        body: StreamBuilder(
          stream: fetchData.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasError) {
              return const Center(child: Text("Something went wrong!"));
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          child: Text(
                            "H! Hungry?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 107, 96),
                              fontSize: 50,
                              fontFamily: 'boldfont',
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          child: Text(
                            "Let’s bring deliciousness to you!",
                            style: TextStyle(
                                fontSize: 27,
                                fontFamily: 'dance',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      for (int i = 0; i < resturants.length; i++)
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductList(
                                      index: i,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                width: 350,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(1, 3),
                                          blurRadius: 3),
                                    ],
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        i % 2 != 0
                                            ? const Color.fromARGB(
                                                255, 168, 168, 168)
                                            : const Color.fromARGB(
                                                255, 255, 216, 216),
                                        i % 2 != 0
                                            ? const Color.fromARGB(
                                                255, 255, 215, 250)
                                            : const Color.fromARGB(
                                                255, 255, 120, 86)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "${resturants[i]['image']}",
                                        height: 150,
                                        width: 150,
                                      ),
                                      Text(
                                        "${resturants[i]['canteen']}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'boldfont',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
