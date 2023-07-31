import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key, required this.title});
  final String title;

  @override
  State<ImagePage> createState() => _ImagePage();
}

class _ImagePage extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Image Page'),
      ),
    );
  }
}
