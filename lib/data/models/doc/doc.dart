import 'package:meta/meta.dart';
import 'dart:convert';

class Docs {
  final List<Docu> data;
  final String status;

  Docs({
    required this.data,
    required this.status,
  });

  factory Docs.fromRawJson(String str) => Docs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Docs.fromJson(Map<String, dynamic> json) => Docs(
    data: List<Docu>.from(json["data"].map((x) => Docu.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Docu {
  final int id;
  final String name;
  final int courseId;
  final String url;
  final Type type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Docu({
    required this.id,
    required this.name,
    required this.courseId,
    required this.url,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Docu.fromRawJson(String str) => Docu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Docu.fromJson(Map<String, dynamic> json) => Docu(
    id: json["id"],
    name: json["name"],
    courseId: json["course_id"],
    url: json["url"],
    type: typeValues.map[json["type"]]!,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "course_id": courseId,
    "url": url,
    "type": typeValues.reverse[type],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum Type {
  DOCUMENT
}

final typeValues = EnumValues({
  "document": Type.DOCUMENT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
