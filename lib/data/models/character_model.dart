import 'package:rick_and_morty_app/domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.image,
    required super.url,
    required super.created,
    super.isFavorite = false
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'], 
      type: json['type'],
      url: json['url'],
      created: json['created']
    );
  }
}
