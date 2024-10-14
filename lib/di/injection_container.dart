// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../data/data_sources/character_remote_data_source.dart';
import '../data/repositories/character_repository_impl.dart';
import '../domain/repositories/character_repository.dart';
import '../domain/usecases/get_characters.dart';
import '../domain/usecases/search_characters.dart';
import '../presentation/blocs/character_bloc/character_bloc.dart';
import '../presentation/blocs/searchcharacter/search_character_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )));


  // Data sources
  sl.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImpl());


  // Repositories
  sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(sl()));


  // Use cases
  sl.registerLazySingleton(() => GetCharacters(sl()));
  sl.registerLazySingleton(() => SearchCharacters(sl()));


  // Blocs
  sl.registerFactory(() => CharacterBloc(sl()));
  sl.registerFactory(() => SearchCharacterBloc(sl()));
}
