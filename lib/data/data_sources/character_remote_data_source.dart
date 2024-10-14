import 'package:rick_and_morty_app/api/rick_morty_api.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> fetchCharacters(int page);
  Future<List<CharacterModel>> fetchCharactersWithName(String name);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  @override
  Future<List<CharacterModel>> fetchCharacters(int page) async {
    try {
      // Agrega el parámetro de página a la URL
      final response =
          await RickMortyApi.get('/character', queryParameters: {'page': page});

      if (response.statusCode == 200) {
        final List<dynamic> charactersJson = response.data['results'];

        return charactersJson
            .map((character) => CharacterModel.fromJson(character))
            .toList();
      } else {
        throw Exception('Error al cargar los personajes');
      }
    } catch (e) {
      throw Exception('Error al cargar los personajes: $e');
    }
  }
  
  @override
  Future<List<CharacterModel>> fetchCharactersWithName(String name) async {
        try {
      // Agrega el parámetro de página a la URL
      final response =
          await RickMortyApi.get('/character', queryParameters: {'name': name});

      if (response.statusCode == 200) {
        final List<dynamic> charactersJson = response.data['results'];

        return charactersJson
            .map((character) => CharacterModel.fromJson(character))
            .toList();
      } else {
        throw Exception('Error al cargar los personajes');
      }
    } catch (e) {
      throw Exception('Error al cargar los personajes: $e');
    }
  }
}
