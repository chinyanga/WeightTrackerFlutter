import 'dart:convert';

List<Weight> weightListFromJson(String str) =>
    List<Weight>.from(json.decode(str).map((x) => Weight.fromJson(x)));

Weight weightFromJson(String str) => Weight.fromJson(json.decode(str));

String weightListToJson(List<Weight> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String weightToJson(Weight data) => json.encode(data.toJson());

class Weight {
  Weight({
    this.id,
    this.weight,
    this.dateTime,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int weight;
  DateTime dateTime;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        weight: json["weight"],
        dateTime: DateTime.parse(json["date_time"]),
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "date_time": dateTime.toIso8601String(),
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
