class Course {
  List<Datum>? data;
  String? status;

  Course({this.data, this.status});

  Course.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(new Datum.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Datum {
  int? id;
  String? name;
  String? description;
  String? image;
  String? status;
  String? userId;
  String? specializationId;
  String? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.status,
      this.userId,
      this.specializationId,
      this.countryId,
      this.createdAt,
      this.updatedAt});

  Datum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    userId = json['user_id'];
    specializationId = json['specialization_id'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    data['user_id'] = userId;
    data['specialization_id'] = specializationId;
    data['country_id'] = countryId;
    data['created_at'] = createdAt!.toIso8601String();
    data['updated_at'] = updatedAt!.toIso8601String();
    return data;
  }
}
// toIso8601String
