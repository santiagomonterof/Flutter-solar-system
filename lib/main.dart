import 'package:flutter/material.dart';
import 'package:flutter_solar_system/detail_page.dart';
import 'package:flutter_solar_system/home_page.dart';
import 'package:flutter_solar_system/principal_page.dart';
import 'package:flutter_solar_system/search_page.dart';
import 'package:flutter_solar_system/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/welcome',
        routes: <String, WidgetBuilder>{
          '/welcome': (BuildContext context) => const WelcomePage(),
          '/principal': (BuildContext context) => const PrincipalPage(
                title: 'Principal Page',
              ),
          '/home': (BuildContext context) => const HomePage(
                title: 'Home Page',
              ),
          '/search': (BuildContext context) => const SearchPage(
                title: '',
              ),
          '/detail': (BuildContext context) => const DetailPage(
                title: '', planet: null,
              ),
        });
  }
}
