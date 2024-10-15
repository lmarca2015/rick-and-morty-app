part of 'search_character_bloc.dart';

abstract class SearchCharacterEvent {}

class FetchCharactersByNameEvent extends SearchCharacterEvent {
  final String name;
  
  FetchCharactersByNameEvent(this.name);
}