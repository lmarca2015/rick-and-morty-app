import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/presentation/blocs/local_character_bloc/local_character_bloc.dart';
import 'package:rick_and_morty_app/presentation/blocs/search_character/search_character_bloc.dart';
import 'package:rick_and_morty_app/ui/screens/detail_screen.dart';
import 'package:rick_and_morty_app/ui/screens/home_screen.dart';
import 'package:rick_and_morty_app/ui/screens/local_characters_screen.dart';

import '../../data/models/character_model.dart';
import '../../di/injection_container.dart';
import '../../presentation/blocs/character_bloc/character_bloc.dart';

final appRouter = GoRouter(initialLocation: '/', routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) {
      return BlocProvider(
        create: (context) => sl<CharacterBloc>(),
        child: const HomeScreen(),
      );
    },
  ),

  GoRoute(
    path: '/detail',
    builder: (context, state) {
      final character = state.extra as CharacterModel;
      return BlocProvider(
        create: (context) => sl<SearchCharacterBloc>(),
        child: DetailScreen(character: character),
      );
    },
  ),
  
  GoRoute(
    path: '/local',
    builder: (context, state) {
      return BlocProvider(
        create: (context) => sl<LocalCharacterBloc>(),
        child: const LocalCharactersScreen(),
      );
    },
  ),
]);
