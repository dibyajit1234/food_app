import 'package:flutter/material.dart';
import 'package:uem_food/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Name",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 255, 82, 70))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already registered ? "),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
