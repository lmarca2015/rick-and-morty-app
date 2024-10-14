import 'dart:convert';

class Info {

    Info({
        required this.count,
        required this.pages,
        required this.next,
        required this.prev,
    });

    int count;
    int pages;
    String next;
    String? prev;

    factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Info.fromMap(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"]
    );

    Map<String, dynamic> toMap() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}