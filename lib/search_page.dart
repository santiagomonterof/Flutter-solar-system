import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_solar_system/models/planet_model.dart';
import 'package:flutter_solar_system/planet_details.dart';
import 'package:flutter_svg/svg.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();


  List<Planet> _planets = [];
  List<Planet> _planetsAux = [];
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchPlanets().then((planets) {
      setState(() {
        _planets = planets;
        _planetsAux = planets;
      });
    });
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

  void filterPlanets(String query) {
    setState(() {
      _planets = _planets
          .where((planet) =>
              planet.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
          if (query.isEmpty) {
            _planets = _planetsAux;
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: filterPlanets,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Search planets',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _planets.length,
                itemBuilder: (context, index) {
                  final planetName = _planets[index].name;
                  return Card(
                    color: Colors.blue, // Color de fondo de la tarjeta
                    child: ListTile(
                      leading: SvgPicture.asset(
                        _planets[index].image, // Ruta de la imagen
                        width: 48, // Ancho de la imagen
                        height: 48, // Alto de la imagen
                      ),
                      title: Text(
                        planetName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        'Descripción del planeta',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Lógica del botón
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanetDetails(
                                planet: _planets[index],
                                title: '',
                              ),
                            ));
                        // Lógica para navegar a la página de detalles del planeta
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
