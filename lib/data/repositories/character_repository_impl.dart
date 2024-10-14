import 'package:rick_and_morty_app/domain/entities/character.dart';

import '../../domain/repositories/character_repository.dart';
import '../data_sources/character_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Character>> fetchCharacters(int page) async {
    return await remoteDataSource.fetchCharacters(page);
  }

    @override
  Future<List<Character>> fetchCharactersWithName(String name) async {
    return await remoteDataSource.fetchCharactersWithName(name);
  }
}
