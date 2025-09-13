import 'package:hive/hive.dart';

part 'character_data.g.dart';

@HiveType(typeId: 0)
class CharacterData {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String gender;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final LocationInfo location;

  CharacterData({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
  });

  factory CharacterData.fromJson(Map<String, dynamic> json) {
    return CharacterData(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
      location: LocationInfo.fromJson(json['location']),
    );
  }

  factory CharacterData.empty() {
    return CharacterData(
      id: 0,
      name: '',
      status: '',
      species: '',
      gender: '',
      location: LocationInfo(name: '', url: ''),
      image: '',
    );
  }
}

@HiveType(typeId: 1)
class LocationInfo {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  LocationInfo({
    required this.name,
    required this.url,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      name: json['name'],
      url: json['url'],
    );
  }
}
