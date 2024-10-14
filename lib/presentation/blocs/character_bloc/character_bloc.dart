import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/usecases/get_characters.dart';


part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  final GetCharacters getCharacters;

  CharacterBloc(this.getCharacters) : super(CharacterInitial()) {
    on<FetchCharactersEvent>((event, emit) async {
      final currentState = state;
      List<Character> existingCharacters = [];

      if (currentState is CharacterLoaded) {
        existingCharacters = currentState.characters;
      }

      emit(Loading());

      try {
        final newCharacters = await getCharacters(event.page);

        final updatedCharacters = List<Character>.from(existingCharacters)
          ..addAll(newCharacters);

        emit(CharacterLoaded(updatedCharacters));
      } catch (e) {
        emit(CharactersError(e.toString()));
      }
    });
  }
}
