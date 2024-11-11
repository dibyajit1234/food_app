import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uem_food/pages/cart_page.dart';
import 'package:uem_food/pages/homepage_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentpage = 0;
  List<Widget> pages = [const HomepageItems(), const CartPage()];
  final CollectionReference fetchData =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {

        FirebaseAuth.instance;

    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    // Access the user's email
    String userEmail = user?.email ?? '';

    // Use the email as needed
    print('Logged-in user email: $userEmail');




    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          backgroundColor: const Color.fromARGB(255, 255, 107, 96),
          onTap: (value) {
            setState(() {
              currentpage = value;
            });
          },
          currentIndex: currentpage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  color: Colors.white,
                  Icons.shopping_cart,
                ),
                label: '')
          ],
        ),
        body: IndexedStack(
          index: currentpage,
          children: pages,
        ));
  }
}
