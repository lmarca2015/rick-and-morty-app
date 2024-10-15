import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/domain/usecases/get_local_characters.dart';
import 'package:rick_and_morty_app/presentation/blocs/local_character_bloc/local_character_bloc.dart';

import '../data/data_sources/character_remote_data_source.dart';
import '../data/data_sources/database_helper.dart';
import '../data/repositories/character_repository_impl.dart';
import '../domain/repositories/character_repository.dart';
import '../domain/usecases/get_characters.dart';
import '../domain/usecases/search_characters.dart';
import '../presentation/blocs/character_bloc/character_bloc.dart';
import '../presentation/blocs/search_character/search_character_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerSingleton<DatabaseHelper>(DatabaseHelper());
  
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
  sl.registerLazySingleton(() => GetLocalCharacters(sl()));


  // Blocs
  sl.registerFactory(() => CharacterBloc(sl()));
  sl.registerFactory(() => SearchCharacterBloc(sl()));
  sl.registerFactory(() => LocalCharacterBloc(sl()));
}