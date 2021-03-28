// To parse this JSON data, do
//
//     final consult = consultFromJson(jsonString);

import 'dart:convert';

Map<String, Consult> consultFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Consult>(k, Consult.fromJson(v)));

String consultToJson(Map<String, Consult> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Consult {
  Consult({
    this.img,
    this.creadtedIn,
    this.numComment,
    this.numLike,
    this.section,
    this.id,
    this.userName,
    this.userId,
    this.desc,
    this.createdIn,
  });

  String img;
  String creadtedIn;
  int numComment;
  int numLike;
  String section;
  int id;
  String userName;
  String userId;
  String desc;
  DateTime createdIn;

  factory Consult.fromJson(Map<String, dynamic> json) => Consult(
    img: json["img"] == null ? null : json["img"],
    creadtedIn: json["creadtedIn"] == null ? null : json["creadtedIn"],
    numComment: json["num_comment"] == null ? null : json["num_comment"],
    numLike: json["num_like"] == null ? null : json["num_like"],
    section: json["section"] == null ? null : json["section"],
    id: json["id"] == null ? null : json["id"],
    userName: json["userName"] == null ? null : json["userName"],
    userId: json["userId"] == null ? null : json["userId"],
    desc: json["desc"] == null ? null : json["desc"],
    createdIn: json["createdIn"] == null ? null : DateTime.parse(json["createdIn"]),
  );

  Map<String, dynamic> toJson() => {
    "img": img == null ? null : img,
    "creadtedIn": creadtedIn == null ? null : creadtedIn,
    "num_comment": numComment == null ? null : numComment,
    "num_like": numLike == null ? null : numLike,
    "section": section == null ? null : section,
    "id": id == null ? null : id,
    "userName": userName == null ? null : userName,
    "userId": userId == null ? null : userId,
    "desc": desc == null ? null : desc,
    "createdIn": createdIn == null ? null : createdIn.toIso8601String(),
  };
}
