import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  bool isRead;
  @HiveField(5)
  String? image;

  NotificationModel({
    required this.id,
    this.image,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  // factory NotificationModel.fromJson(Map<String, dynamic> json) {
  //   return NotificationModel(
  //     title: json['title'],
  //     message: json['message'],
  //     timestamp: DateTime.parse(json['timestamp']),
  //   );
  // }
}
