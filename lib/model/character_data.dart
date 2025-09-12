class CharacterData {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
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

class LocationInfo {
  final String name;
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
