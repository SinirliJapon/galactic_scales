class SpaceObject {
  final int id;
  final String name;
  final String nickname;
  final String objectType;
  final String moonOf;
  final double size;
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
    required this.nickname,
    required this.objectType,
    required this.moonOf,
    required this.size,
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
      nickname: json['nickname'] as String,
      objectType: json['objectType'] as String,
      moonOf: json['moonOf'] as String,
      size: json['size'] != null ? (json['size'] as num).toDouble() : 0.0,
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
