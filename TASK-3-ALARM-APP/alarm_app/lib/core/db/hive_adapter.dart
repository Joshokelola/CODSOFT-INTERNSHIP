import 'package:alarm_app/features/alarm/domain/alarm.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapter.g.dart';

@GenerateAdapters([AdapterSpec<Alarm>()])
// Annotations must be on some element
// ignore: unused_element
void _() {}