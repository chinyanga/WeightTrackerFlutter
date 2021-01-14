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
    this.target_weight,
    this.date_time,
    this.user_id,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int weight;
  int target_weight;
  DateTime date_time;
  int user_id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        weight: json["weight"],
        target_weight: json["target_weight"],
        date_time: DateTime.parse(json["date_time"]),
        user_id: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weight": weight,
        "target_weight": target_weight,
        "date_time": date_time == null
            ? DateTime.now().toIso8601String()
            : date_time.toIso8601String(),
        "user_id": user_id,
      };
}
