import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.title, required planet});
  final String title;

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
    );
  }
}
