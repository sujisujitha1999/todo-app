import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  String? description;
  String? dateTime;
  bool? priority;
  String? type;

  TodoModel(
      {this.id,
      this.title,
      this.description,
      this.dateTime,
      this.priority,
      this.type});

  TodoModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["dateTime"] is String) {
      dateTime = json["dateTime"];
    }
    if (json["priority"] is bool) {
      priority = json["priority"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
  }

  factory TodoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return TodoModel(
        id: data["id"],
        dateTime: data["dateTime"],
        description: data["description"],
        priority: data["priority"],
        title: data["title"],
        type: data["type"]);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["dateTime"] = dateTime;
    _data["priority"] = priority;
    _data["type"] = type;
    return _data;
  }
}
