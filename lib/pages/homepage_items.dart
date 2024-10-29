import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uem_food/globalvariable.dart';
import 'package:uem_food/pages/product_list.dart';

class HomepageItems extends StatefulWidget {
  const HomepageItems({super.key});

  @override
  State<HomepageItems> createState() => _HomepageItems();
}

class _HomepageItems extends State<HomepageItems> {
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Foodgo",
                              style:
                                  TextStyle(fontFamily: "updock", fontSize: 45),
                            ),
                            //Text("order your favourite")
                          ],
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/profile.jpg"),
                        )
                      ],
                    ),
                    const Text(
                      'Order your favourite food!',
                      style: TextStyle(fontFamily: "order", fontSize: 17),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        child: Text(
                          "Hi! Hungry?",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductList(index: i);
                                  },
                                ),
                              );
                            },
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
                                              255, 194, 194, 194)
                                          : const Color.fromARGB(
                                              255, 255, 216, 216),
                                      i % 2 != 0
                                          ? const Color.fromARGB(
                                              255, 226, 222, 222)
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
