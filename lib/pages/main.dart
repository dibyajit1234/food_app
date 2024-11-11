import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uem_food/cart_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uem_food/pages/home_page.dart';
import 'package:uem_food/pages/landing_page.dart';
import '../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'allfont'),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
