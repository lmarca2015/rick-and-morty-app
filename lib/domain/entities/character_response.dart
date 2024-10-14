import 'dart:convert';

import 'package:rick_and_morty_app/domain/entities/character.dart';
import 'package:rick_and_morty_app/domain/entities/info.dart';

class CharacterResponse {

    CharacterResponse({
        required this.info,
        required this.results,
    });

    Info info;
    List<Character> results;

    
    factory CharacterResponse.fromJson(String str) => CharacterResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CharacterResponse.fromMap(Map<String, dynamic> json) => CharacterResponse(
        info: Info.fromMap(json["info"]),
        results: List<Character>.from(json["results"].map((x) => Character.fromMap(x)))
    );

    Map<String, dynamic> toMap() => {
        "info": info.toMap(),
        "results": List<dynamic>.from(results.map((x) => x))
    };
}