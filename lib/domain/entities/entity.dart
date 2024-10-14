import 'dart:convert';

class Entity {

    Entity({
        required this.name,
        required this.url,
    });

    String name;
    String url;

    factory Entity.fromJson(String str) => Entity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Entity.fromMap(Map<String, dynamic> json) => Entity(
        name: json["name"],
        url: json["url"]
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "url": url
    };
}