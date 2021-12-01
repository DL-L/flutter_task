// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    required this.id,
    required this.relationId,
    required this.title,
    required this.description,
    required this.statusId,
    required this.deadline,
    this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  String id;
  int relationId;
  String title;
  String description;
  int statusId;
  DateTime deadline;
  dynamic createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        relationId: json["relation_id"],
        title: json["title"],
        description: json["description"],
        statusId: json["status_id"],
        deadline: json["deadline"] == null
            ? DateTime(0000)
            : DateTime.parse(json["deadline"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? DateTime(0000)
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "relation_id": relationId,
        "title": title,
        "description": description,
        "status_id": statusId,
        "deadline": deadline == null
            ? null
            : "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
