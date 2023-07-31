import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF151515),
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'buckle up',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const Text(
                  'What are you going to learn today?',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/principal');
                  },
                  label: const Text('Start Now'),
                  icon: const Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF5F53),
                  ),
                ),
              ],
            )));
  }
}
