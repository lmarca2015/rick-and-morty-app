import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

import '../../../domain/usecases/search_characters.dart';


part 'search_character_event.dart';
part 'search_character_state.dart';

class SearchCharacterBloc extends Bloc<SearchCharacterEvent, SearchCharacterState> {

  final SearchCharacters searchCharacters;

  SearchCharacterBloc(this.searchCharacters) : super(CharacterInitial()) {
    on<FetchCharactersByNameEvent>((event, emit) async {
      final currentState = state;
      List<Character> existingCharacters = [];

      if (currentState is CharacterLoaded) {
        existingCharacters = currentState.characters;
      }

      emit(Loading());

      try {
        final newCharacters = await searchCharacters(event.name);

        final updatedCharacters = List<Character>.from(existingCharacters)
          ..addAll(newCharacters);

        emit(CharacterLoaded(updatedCharacters));
      } catch (e) {
        emit(CharactersError(e.toString()));
      }
    });
  }
}
