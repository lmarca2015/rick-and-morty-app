part of 'local_character_bloc.dart';

abstract class LocalCharacterState {}

class CharacterInitial extends LocalCharacterState {}

class Loading extends LocalCharacterState {}

class LocalCharacterLoaded extends LocalCharacterState {
  final List<Character> characters;

  LocalCharacterLoaded(this.characters);
}

class CharactersError extends LocalCharacterState {
  final String message;
  
  CharactersError(this.message);
}