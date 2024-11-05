import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/api/rick_morty_api.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';

import '../../domain/entities/character.dart';
import 'database_helper.dart';

abstract class CharacterRemoteDataSource {
  Future<List<Character>> fetchCharacters(int page);
  Future<List<Character>> fetchCharactersWithName(String name);

  Future<List<CharacterModel>> fetchLocalCharacters();
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final _databaseHelper = GetIt.instance<DatabaseHelper>();

  @override
  Future<List<CharacterModel>> fetchCharacters(int page) async {
    try {
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

  @override
  Future<List<CharacterModel>> fetchLocalCharacters() {
    return _databaseHelper.getCharacters();
  }
}
