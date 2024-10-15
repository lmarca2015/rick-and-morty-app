import 'dart:convert';

class Character {

    Character({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.type,
        required this.gender,
        required this.image,
        required this.url,
        required this.created,
        this.isFavorite = false
    });

    int id;
    String name;
    String status;
    String species;
    String type;
    String gender;
    String image;
    String url;
    String created;
    bool isFavorite;

    factory Character.fromJson(String str) => Character.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Character.fromMap(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        image: json["image"],
        url: json["url"],
        created: json["created"],
        isFavorite: json['isFavorite'] == 1
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "image": image,
        "url": url,
        "created": created,
        'isFavorite': isFavorite ? 1 : 0
    };
}