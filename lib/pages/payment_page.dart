import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uem_food/functions/cart_provider.dart';
import 'package:uem_food/functions/firestore.dart';
import 'package:uem_food/pages/recipt_page.dart';
import 'dart:developer';

class PaymentPage extends StatefulWidget {
  final dynamic totalprice;
  const PaymentPage({super.key, required this.totalprice});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  DateTime currentTime = DateTime.now();
  FirestoreService db = FirestoreService();

  final name = TextEditingController();
  final contact = TextEditingController();
  final building = TextEditingController();
  final room = TextEditingController();
  bool validateInput() {
    if (name.text.isEmpty ||
        contact.text.isEmpty ||
        building.text.isEmpty ||
        room.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!!')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: true).cart;
    FirebaseAuth.instance;
    final user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? '';

    Future sendEmail({
      required String username,
      required String email,
      required String subject,
      required String message,
    }) async {
      const serviceid = 'service_vybrui6';
      const templetid = 'template_ws8ilhf';
      const userid = 'g0QSQWOA2y2jtmUuE';

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        },
        body: json.encode(
          {
            'user_id': userid,
            'service_id': serviceid,
            'template_id': templetid,
            'template_params': {
              'user_name': username,
              'to_email': userEmail,
              'user_subject': subject,
              'user_message': message,
            }
          },
        ),
      );
      if (response.statusCode != 200) {
        log("email not send${response.body}");
      } else {
        log("email sent successfully");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Center(child: Text("Payment")),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          controller: contact,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: "Contact No.",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          controller: building,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: "Building Name",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          controller: room,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2),
                              ),
                              hintText: "Room No.",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                "* We provide cash on delivery only!!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 243, 243)),
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
                              "Rs. ${widget.totalprice}",
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (name.text != '' &&
                              contact.text != '' &&
                              building.text != '' &&
                              room.text != '') {
                            Provider.of<CartProvider>(context).adddetails(
                              {
                                'procudts': cart,
                                'name': name.text,
                                'contact': contact.text,
                                'building': building.text,
                                'room No': room.text,
                                'time': currentTime,
                              },
                            );
                            setState(() {});
                            final reciept =
                                Provider.of<CartProvider>(context).receipt;
                            db.SaveOrderToDatabase(reciept);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ReciptPage(
                                    total: widget.totalprice,
                                    name: name.text,
                                    contact: contact.text,
                                    building: building.text,
                                    room: room.text,
                                  );
                                },
                              ),
                            );
                            sendEmail(
                                username: name.text,
                                email: userEmail,
                                subject: 'Order conformation',
                                message: '${widget.totalprice}');
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Please fill all the required fields!!"),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 107, 96),
                          fixedSize: const Size(150, 40),
                        ),
                        child: const Text(
                          "Place Order!",
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
        ),
      ),
    );
  }
}
