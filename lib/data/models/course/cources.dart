import 'package:meta/meta.dart';
import 'dart:convert';

class Course {
  final List<Datum> data;
  final String status;

  Course({
    required this.data,
    required this.status,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  final int id;
  final String name;
  final String description;
  final dynamic image;
  final String status;
  final String userId;
  final String specializationId;
  final String countryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.status,
    required this.userId,
    required this.specializationId,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    userId: json["user_id"],
    specializationId: json["specialization_id"],
    countryId: json["country_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "status": status,
    "user_id": userId,
    "specialization_id": specializationId,
    "country_id": countryId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
