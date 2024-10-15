import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/domain/entities/character.dart';

import '../../../domain/usecases/get_local_characters.dart';

part 'local_character_event.dart';
part 'local_character_state.dart';

class LocalCharacterBloc extends Bloc<LocalCharacterEvent, LocalCharacterState> {

  final GetLocalCharacters getCharacters;

  LocalCharacterBloc(this.getCharacters) : super(CharacterInitial()) {
    on<FetchLocalCharactersEvent>((event, emit) async {
      emit(Loading());

      try {
        final characters = await getCharacters();

        emit(LocalCharacterLoaded(characters));
      } catch (e) {
        emit(CharactersError(e.toString()));
      }
    });
  }
}
