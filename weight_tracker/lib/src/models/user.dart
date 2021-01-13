import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {this.id,
      this.username,
      this.pwd,
      this.weight,
      this.target_weight,
      this.dob,
      this.accessToken});

  int id;
  String username;
  String pwd;
  int weight;
  int target_weight;
  DateTime dob;
  String accessToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        pwd: json["pwd"],
        weight: json["weight"],
        target_weight: json["target_weight"],
        dob: DateTime.parse(json["dob"]),
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "pwd": pwd,
        "weight": weight,
        "target_weight": target_weight,
        "dob": dob == null
            ? "${DateTime.now().year.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}"
            : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
      };
}
