import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uem_food/pages/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //container for written text
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromARGB(255, 255, 186, 186),
                Color.fromARGB(255, 255, 72, 72)
              ],
            ),
          ),
          child: const Expanded(
            child: Center(
              child: Text(
                "Food go",
                style: TextStyle(
                    fontSize: 80, color: Colors.white, fontFamily: "updock"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
