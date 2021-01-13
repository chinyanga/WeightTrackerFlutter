import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.username,
    this.pwd,
    this.weight,
    this.targetWeight,
    this.dob,
  });

  int id;
  String username;
  String pwd;
  int weight;
  int targetWeight;
  DateTime dob;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        pwd: json["pwd"],
        weight: json["weight"],
        targetWeight: json["target_weight"],
        dob: DateTime.parse(json["dob"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "pwd": pwd,
        "weight": weight,
        "target_weight": targetWeight,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
      };
}
