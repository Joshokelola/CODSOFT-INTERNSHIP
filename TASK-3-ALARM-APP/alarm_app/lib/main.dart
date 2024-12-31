import 'package:alarm/alarm.dart';
import 'package:alarm_app/alarm_service.dart';
import 'package:alarm_app/hive_adapter.dart';
import 'package:alarm_app/home_screen.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await checkAndroidScheduleExactAlarmPermission();
  // await Alarm.init();
  await AlarmService.init();
// AlarmService.updateToggle();
  runApp(const MainApp());
}

// Future<void> checkAllPermissions() async {
//   await checkAndroidScheduleExactAlarmPermission();

//   try {
//     bool? isAvailable = await isAutoStartAvailable;
//     if (isAvailable!) {
//       await getAutoStartPermission();
//     }
//   } catch (e) {
//     print('Error checking auto-start: $e');
//   }
// }

Future<void> checkAndroidScheduleExactAlarmPermission() async {
  final status = await Permission.scheduleExactAlarm.status;
  print('Schedule exact alarm permission: $status.');
  if (status.isDenied) {
    print('Requesting schedule exact alarm permission...');
    final res = await Permission.scheduleExactAlarm.request();
    print(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF6A9FB5),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFB3D9E8),
          onPrimaryContainer: Color(0xFF003647),
          secondary: Color(0xFFB8D5D8),
          onSecondary: Color(0xFF002C30),
          secondaryContainer: Color(0xFFD9ECEF),
          onSecondaryContainer: Color(0xFF1A4F52),
          tertiary: Color(0xFFDABCC6),
          onTertiary: Color(0xFF4A1D28),
          tertiaryContainer: Color(0xFFF5E5EB),
          onTertiaryContainer: Color(0xFF5F2C39),
          error: Color(0xFFB3261E),
          onError: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF4A5568),
          outline: Color(0xFF94A3B8),
        ),
      ),
    );
  }
}
