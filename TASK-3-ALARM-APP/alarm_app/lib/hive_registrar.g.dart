// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:alarm_app/hive_adapter.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(AlarmAdapter());
  }
}