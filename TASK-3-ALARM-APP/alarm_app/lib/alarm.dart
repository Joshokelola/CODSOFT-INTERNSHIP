import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class Alarm extends HiveObject {
  final String id;
  TimeOfDay time;
  String label;
  bool isActive;
  bool allowVibration;
  String alarmTone;

  Alarm({
    String? id,
    required this.time,
    this.label = '',
    this.isActive = true,
    this.alarmTone = 'alarm2.mp3',
    this.allowVibration = true,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  // Convert time to string format
  String getTimeString() {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': '${time.hour}:${time.minute}',
      'label': label,
      'isActive': isActive,
      'alarmTone': alarmTone,
      'allowVibration': allowVibration,
    };
  }

  // Create from Map
  factory Alarm.fromMap(Map<String, dynamic> map) {
    final timeComponents = map['time'].split(':');
    return Alarm(
      id: map['id'],
      time: TimeOfDay(
          hour: int.parse(timeComponents[0]),
          minute: int.parse(timeComponents[1])),
      label: map['label'],
      isActive: map['isActive'],
      alarmTone: map['alarmTone'],
      allowVibration: map['allowVibration'],
    );
  }
}
