import 'package:flutter/material.dart';
import 'package:flutter_solar_system/detail_page.dart';
import 'package:flutter_solar_system/home_page.dart';
import 'package:flutter_solar_system/image_page.dart';
import 'package:flutter_solar_system/search_page.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key, required this.title});
  final String title;

  @override
  State<PrincipalPage> createState() => _PrincipalPage();
}

class _PrincipalPage extends State<PrincipalPage> {
  List<Widget> widgets = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    widgets.add(const HomePage(title: '',));
    widgets.add(const SearchPage(
      title: '',
    ));
    widgets.add(const DetailPage(
      title: '', planet: null,
    ));
    widgets.add(const ImagePage(
      title: '',
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[_selectedIndex],
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save),
          label: 'Save',
          backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: 'Image',
          backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black,
      onTap: _onItemTapped,
    );
  }
}
