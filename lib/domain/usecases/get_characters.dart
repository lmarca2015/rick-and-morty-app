import 'package:rick_and_morty_app/domain/repositories/character_repository.dart';
import '../entities/character.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<List<Character>> call(int page) async {
    return await repository.fetchCharacters(page);
  }
}