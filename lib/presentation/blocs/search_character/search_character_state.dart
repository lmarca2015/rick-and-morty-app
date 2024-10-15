part of 'search_character_bloc.dart';


abstract class SearchCharacterState {}

class CharacterInitial extends SearchCharacterState {}

class Loading extends SearchCharacterState {}

class CharacterLoaded extends SearchCharacterState {
  final List<Character> characters;

  CharacterLoaded(this.characters);
}

class CharactersError extends SearchCharacterState {
  final String message;
  
  CharactersError(this.message);
}