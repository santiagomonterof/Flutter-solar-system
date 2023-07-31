import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'models/planet_model.dart';

class PlanetDetails extends StatelessWidget {
  final Planet planet;

  const PlanetDetails({super.key, required this.planet, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              planet.image,
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 16.0),
            Text('Tipo: ${planet.type}'),
            const SizedBox(height: 8.0),
            Text('Resumen: ${planet.resume}'),
            const SizedBox(height: 8.0),
            Text('Introducción: ${planet.introduction}'),
            const SizedBox(height: 8.0),
            const Text('Características:'),
            const SizedBox(height: 8.0),
            Text(' - Orbital Period: ${planet.features.orbitalPeriod.join(", ")}'),
            Text(' - Orbital Speed: ${planet.features.orbitalSpeed}'),
            Text(' - Duración de Rotación: ${planet.features.rotationDuration}'),
            Text(' - Radio: ${planet.features.radius}'),
            Text(' - Diámetro: ${planet.features.diameter}'),
            Text(' - Distancia al Sol: ${planet.features.sunDistance}'),
            Text(' - Luz de ida al Sol: ${planet.features.oneWayLightToTheSun}'),
            Text(' - Número de Satélites: ${planet.features.satellites.number}'),
            Text(' - Satélites: ${planet.features.satellites.names.join(", ")}'),
            Text(' - Temperatura: ${planet.features.temperature}'),
            Text(' - Gravedad: ${planet.features.gravity}'),
            const SizedBox(height: 8.0),
            Text('Geografía: ${planet.geography}'),
          ],
        ),
      ),
    );
  }
}