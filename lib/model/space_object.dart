class SpaceObject {
  final int id;
  final String name;
  final String objectType;
  final double mass;
  final double orbits;
  final double distanceFromSun;
  final double distanceFromEarth;
  final double surfaceTemperature;
  final String description;
  final String image;
  final String url;

  SpaceObject({
    required this.id,
    required this.name,
    required this.objectType,
    required this.mass,
    required this.orbits,
    required this.distanceFromSun,
    required this.distanceFromEarth,
    required this.surfaceTemperature,
    required this.description,
    required this.image,
    required this.url,
  });

  factory SpaceObject.fromJson(Map<String, dynamic> json) {
    return SpaceObject(
      id: json['id'] as int,
      name: json['name'] as String,
      objectType: json['objectType'] as String,
      mass: json['mass'] != null ? (json['mass'] as num).toDouble() : 0.0,
      orbits: json['orbits'] != null ? (json['orbits'] as num).toDouble() : 0.0,
      distanceFromSun: json['distance_from_sun'] != null ? (json['distance_from_sun'] as num).toDouble() : 0.0,
      distanceFromEarth: json['distance_from_earth'] != null ? (json['distance_from_earth'] as num).toDouble() : 0.0,
      surfaceTemperature: json['surface_temperature'] != null ? (json['surface_temperature'] as num).toDouble() : 0.0,
      description: json['description'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
    );
  }
}
