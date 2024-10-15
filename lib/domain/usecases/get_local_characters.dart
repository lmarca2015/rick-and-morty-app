import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetLocalCharacters {
  final CharacterRepository repository;

  GetLocalCharacters(this.repository);

  Future<List<Character>> call() async {
    return await repository.fetchLocalCharacters();
  }
}