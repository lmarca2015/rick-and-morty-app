import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/presentation/blocs/search_character/search_character_bloc.dart';

import '../../di/injection_container.dart';

class SearchCharacter extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  String? lastQuery;

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return BlocProvider(
      create: (context) => sl<SearchCharacterBloc>(),
      child: BlocBuilder<SearchCharacterBloc, SearchCharacterState>(
        builder: (context, state) {
          if (query.isNotEmpty && query != lastQuery) {
            lastQuery = query;
            context
                .read<SearchCharacterBloc>()
                .add(FetchCharactersByNameEvent(query));
          }

          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CharacterLoaded) {
            final characters = state.characters;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return GestureDetector(
                  onTap: () {
                    context.go('/detail', extra: character);
                  },
                  child: ListTile(
                    title: Text(character.name),
                    leading: Hero(
                        tag: character.id,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(character.image))),
                  ),
                );
              },
            );
          } else if (state is CharactersError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No results"));
          }
        },
      ),
    );
  }
}
