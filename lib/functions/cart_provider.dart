import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];
    final List<Map<String, dynamic>> receipt = [];
      void adddetails(Map<String, dynamic> product) {
    receipt.add(product);
    notifyListeners();
  }
  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}


