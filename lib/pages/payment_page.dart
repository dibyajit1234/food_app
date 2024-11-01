import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding:  EdgeInsets.only(right: 40.0),
          child: Center(child: Text("Payment")),
        ),
      ),
   
    );
  }
}
