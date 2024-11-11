import 'package:flutter/material.dart';
import 'package:uem_food/auth_service.dart';
import 'package:uem_food/pages/home_page.dart';
import 'package:uem_food/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = AuthService();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "^ Foodgo ^",
            style: TextStyle(
                fontFamily: 'updock', fontSize: 55, color: Colors.red),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: _name,
                decoration: const InputDecoration(
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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: _email,
                decoration: const InputDecoration(
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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: const InputDecoration(
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
              onPressed: () async {
                final user = await _auth.signInWithEmailAndPassword(
                    _email.text, _password.text);
                if (user != null) {
                  print("user created successfully");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Invalid username or password!")));
                }
              },
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 255, 82, 70))),
              child: const Text(
                "Register",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already registered ? "),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text("Login"))
              ],
            )
          ],
        ),
      )),
    );
  }
}
