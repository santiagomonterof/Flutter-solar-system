// To parse this JSON data, do
//
//     final planeta = planetaFromJson(jsonString);

import 'dart:convert';

Planet planetFromJson(String str) => Planet.fromJson(json.decode(str));

String planetToJson(Planet data) => json.encode(data.toJson());

class Planet {
  String id;
  String name;
  String type;
  String resume;
  String introduction;
  String image;
  List<String> searchTags;
  Features features;
  String geography;

  Planet({
    required this.id,
    required this.name,
    required this.type,
    required this.resume,
    required this.introduction,
    required this.image,
    required this.searchTags,
    required this.features,
    required this.geography,
  });

  factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        resume: json["resume"],
        introduction: json["introduction"],
        image: json["image"],
        searchTags: List<String>.from(json["searchTags"].map((x) => x)),
        features: Features.fromJson(json["features"]),
        geography: json["geography"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "resume": resume,
        "introduction": introduction,
        "image": image,
        "searchTags": List<dynamic>.from(searchTags.map((x) => x)),
        "features": features.toJson(),
        "geography": geography,
      };
}

class Features {
  List<String> orbitalPeriod;
  String orbitalSpeed;
  String rotationDuration;
  String radius;
  String diameter;
  String sunDistance;
  String oneWayLightToTheSun;
  Satellites satellites;
  String temperature;
  String gravity;

  Features({
    required this.orbitalPeriod,
    required this.orbitalSpeed,
    required this.rotationDuration,
    required this.radius,
    required this.diameter,
    required this.sunDistance,
    required this.oneWayLightToTheSun,
    required this.satellites,
    required this.temperature,
    required this.gravity,
  });

  factory Features.fromJson(Map<String, dynamic> json) => Features(
        orbitalPeriod: List<String>.from(json["orbitalPeriod"].map((x) => x)),
        orbitalSpeed: json["orbitalSpeed"],
        rotationDuration: json["rotationDuration"],
        radius: json["radius"],
        diameter: json["Diameter"],
        sunDistance: json["sunDistance"],
        oneWayLightToTheSun: json["oneWayLightToTheSun"],
        satellites: Satellites.fromJson(json["satellites"]),
        temperature: json["temperature"],
        gravity: json["gravity"],
      );

  Map<String, dynamic> toJson() => {
        "orbitalPeriod": List<dynamic>.from(orbitalPeriod.map((x) => x)),
        "orbitalSpeed": orbitalSpeed,
        "rotationDuration": rotationDuration,
        "radius": radius,
        "Diameter": diameter,
        "sunDistance": sunDistance,
        "oneWayLightToTheSun": oneWayLightToTheSun,
        "satellites": satellites.toJson(),
        "temperature": temperature,
        "gravity": gravity,
      };
}

class Satellites {
  int number;
  List<String> names;

  Satellites({
    required this.number,
    required this.names,
  });

  factory Satellites.fromJson(Map<String, dynamic> json) => Satellites(
        number: json["number"],
        names: List<String>.from(json["names"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "names": List<dynamic>.from(names.map((x) =>x)),
};
}