import 'dart:io';

import 'package:alarm/alarm.dart' as al;
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm/model/notification_settings.dart';
import 'package:alarm_app/alarm.dart';
import 'package:alarm_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class AlarmService {
  static late Box<Alarm> _alarmBox;

  static Future<void> init() async {
    await al.Alarm.init();
    _alarmBox = await Hive.openBox<Alarm>('alarms');

    // Listen to the alarm update stream
    al.Alarm.updateStream.stream.listen((event) {
      print("Alarm updated: $event");
    });
  }

  static bool isValidAlarmTime(DateTime alarmTime) {
    final currentTime = DateTime.now();
    return alarmTime.isAfter(currentTime);
  }

  static DateTime timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
  }

  static Future<void> addAlarm(Alarm alarm) async {
    if (!isValidAlarmTime(timeOfDayToDateTime(alarm.time))) {
      throw Exception('The alarm time must be later than the current time.');
    }
    // Save the alarm in Hive
    await _alarmBox.put(alarm.id, alarm);

    // Set the alarm
    final alarmSettings = al.AlarmSettings(
      id: int.tryParse(alarm.id)!,
      dateTime: timeOfDayToDateTime(alarm.time),
      assetAudioPath: 'assets/${alarm.alarmTone}',
      loopAudio: true,
      vibrate: alarm.allowVibration,
      volume: 0.8,
      fadeDuration: 3.0,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      notificationSettings: NotificationSettings(
        title: alarm.label,
        body: '...',
        stopButton: 'stop',
      ),
    );
    debugPrint(alarmSettings.assetAudioPath);
    await al.Alarm.set(alarmSettings: alarmSettings);
  }

  static void updateToggle() async {
    al.Alarm.ringStream.stream
        .listen((alarm) => toggleAlarm(alarm.id.toString()));
  }

  static Future<void> updateAlarm(Alarm updatedAlarm) async {
    await addAlarm(updatedAlarm); // Adding replaces the existing alarm
  }

  static Future<void> deleteAlarm(String id) async {
    await al.Alarm.stop(int.tryParse(id)!);
    await _alarmBox.delete(id);
  }

  static void clear() {
    _alarmBox.clear();
  }
  // static List<Alarm> getAlarms() {
  //   return _alarmBox.values.toList();
  // }

  static ValueListenable<Box<Alarm>> getAllAlarms() {
    return _alarmBox.listenable();
  }

  static Future<void> toggleAlarm(String id) async {
    final alarm = _alarmBox.get(id);
    debugPrint(id.toString());
    debugPrint(alarm?.label);
    if (alarm != null && isValidAlarmTime(timeOfDayToDateTime(alarm.time))) {
      alarm.isActive = !alarm.isActive;
      // Update the alarm in Hive
      await _alarmBox.put(id, alarm);

      if (alarm.isActive) {
        // Activate the alarm
        DateTime timeOfDayToDateTime(TimeOfDay time) {
          final now = DateTime.now();
          return DateTime(
            now.year,
            now.month,
            now.day,
            time.hour,
            time.minute,
          );
        }

        final alarmSettings = al.AlarmSettings(
          id: int.tryParse(alarm.id)!,
          dateTime: timeOfDayToDateTime(alarm.time),
          assetAudioPath: 'assets/${alarm.alarmTone}',
          loopAudio: true,
          vibrate: alarm.allowVibration,
          volume: 0.8,
          fadeDuration: 3.0,
          warningNotificationOnKill: Platform.isIOS,
          androidFullScreenIntent: true,
          notificationSettings: NotificationSettings(
            title: alarm.label,
            body: '...',
            stopButton: 'stop',
          ),
        );
        await al.Alarm.set(alarmSettings: alarmSettings);
      } else {
        //  await al.Alarm.stop(int.tryParse(id)!);
      }
    } else {
      debugPrint('Invalid time');
    }
  }
}
