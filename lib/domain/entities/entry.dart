import 'dart:convert';

class Entry {
  final String name;
  final String description;
  final String family;
  final String image;

  Entry({
    required this.name,
    required this.description,
    required this.family,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'family': family,
      'image': image,
    };
  }
  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      name: map['name'] as String,
      description: map['description']as String,
      family: map['family']as String,
      image: map['image'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source) as Map<String, dynamic>);


}