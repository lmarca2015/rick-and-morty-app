part of 'character_bloc.dart';

abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class Loading extends CharacterState {}

class CharacterLoaded extends CharacterState {
  final List<Character> characters;

  CharacterLoaded(this.characters);
}

class CharactersError extends CharacterState {
  final String message;
  
  CharactersError(this.message);
}