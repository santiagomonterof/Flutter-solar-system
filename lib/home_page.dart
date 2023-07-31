import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_solar_system/detail_page.dart';

import 'models/category_model.dart';
import 'models/planet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  final List<Category> _categories = [];
  List<Planet> _planets = [];
  List<Planet> _planetsAux = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadCategories();
    fetchPlanets().then((planets) {
      setState(() {
        _planets = planets;
        _planetsAux = planets;
      });
    });
  }

  loadCategories() {
    _categories.add(Category(
        imagen: "assets/icons/planets.svg",
        nombre: "Planetas",
        colorOne: const Color(0xFF5935FF),
        colorTwo: const Color(0xFF47408E)));
    _categories.add(Category(
        imagen: "assets/icons/asteroids.svg",
        nombre: "Asteróides",
        colorOne: const Color(0xFFFF6CD9),
        colorTwo: const Color(0xFFFF2184)));
    _categories.add(Category(
        imagen: "assets/icons/stars.svg",
        nombre: "Estrelas",
        colorOne: const Color(0xFF01D4E4),
        colorTwo: const Color(0xFF009DE0)));
    _categories.add(Category(
        imagen: "assets/icons/galaxies.svg",
        nombre: "Galáxias",
        colorOne: const Color(0xFFF9C270),
        colorTwo: const Color(0xFFFFAA2B)));
  }

  Future<List<Planet>> fetchPlanets() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    final data = json.decode(jsonString);

    final List<dynamic> planetsJson = data['planets'];
    final List<Planet> planets = [];

    for (var planetJson in planetsJson) {
      final Planet planet = Planet(
        id: planetJson['id'],
        name: planetJson['name'],
        type: planetJson['type'],
        resume: planetJson['resume'],
        introduction: planetJson['introduction'],
        image: planetJson['image'],
        searchTags: List<String>.from(planetJson['searchTags'].map((x) => x)),
        features: Features.fromJson(planetJson['features']),
        geography: planetJson['geography'],
      );
      planets.add(planet);
    }

    return planets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Olá, ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Ana Cecília',
                          style: TextStyle(
                              color: Color(0xFFFF2184),
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    size: 24,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 20),
              child: Text(
                "O que você vai aprender hoje?",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
        toolbarHeight: 140,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/search");
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: const BoxDecoration(
                    color: Color(0xFF151515),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: TextField(
                  enabled: true, // Habilitar la escritura
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: "Procure planetas, asteroides, estrelas...",
                      hintStyle: TextStyle(color: Color(0xA6FFFFFF)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      fillColor: Color(0xFF151515),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.0)))),
                  onChanged: (value) {
                    setState(() {
                      _planets = _planets
                          .where((planeta) => planeta.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      if (value.isEmpty) {
                        _planets = _planetsAux;
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                  "Categories",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 24.0),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.height * 0.15,
                    margin: const EdgeInsets.only(top: 8, right: 16, bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            _categories[index].colorOne,
                            _categories[index].colorTwo
                          ],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _categories[index].imagen,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _categories[index].nombre,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                  );
                },
                itemCount: _categories.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Text(
                  "Planetas",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 24.0),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            planet: _planets[index],
                            title: '',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.2,
                          decoration: const BoxDecoration(
                            color: Color(0xFF151515),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: -50,
                                top: -30,
                                child: Hero(
                                  tag: _planets[index].id,
                                  child: SvgPicture.asset(
                                    _planets[index].image,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                right: 20,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _planets[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Color(0xFFFA8F70),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _planets.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
