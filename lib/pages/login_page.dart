import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uem_food/auth_service.dart';
import 'package:uem_food/pages/home_page.dart';
import 'package:uem_food/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: 500,
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
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: 500,
                child: TextField(
                  controller: _password,
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
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 255, 82, 70))),
                  onPressed: () async {
                    final user = await _auth.loginWithEmailAndPassword(
                        _email.text, _password.text);
                    if (user != null) {
                      print("user logged in succesfully");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Invalid userid or password!",
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // await _auth.signinWithgoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 192, 192, 192),
                        width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      Text("  Login with google")
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: const Text("Regester"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
