import '../entities/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> fetchCharacters(int page);
  Future<List<Character>> fetchCharactersWithName(String name);
}