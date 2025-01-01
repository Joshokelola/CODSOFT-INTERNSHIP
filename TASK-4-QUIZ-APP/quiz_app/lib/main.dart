import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/features/home/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
      home: HomeScreen(),
    );
  }
}
