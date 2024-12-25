import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/home/presentation/home_page.dart';

import 'app/providers/todo_providers.dart';
import 'app/services/db.dart';

late ObjectBox objectbox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  runApp( ProviderScope(
     overrides: [
        objectBoxProvider.overrideWithValue(objectbox),
      ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  // Custom color scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6A9FB5), // Soft teal-blue
    onPrimary: Color(0xFFFFFFFF), // White for contrast text/icons
    primaryContainer: Color(0xFFB3D9E8), // Lighter teal for background containers
    onPrimaryContainer: Color(0xFF003647), // Dark teal for text/icons on light backgrounds
    secondary: Color(0xFFB8D5D8), // Pale aqua for accents
    onSecondary: Color(0xFF002C30), // Darker tone for text/icons on secondary
    secondaryContainer: Color(0xFFD9ECEF), // Very light aqua
    onSecondaryContainer: Color(0xFF1A4F52), // Dark aqua for text/icons
    tertiary: Color(0xFFDABCC6), // Soft lavender-pink for highlights
    onTertiary: Color(0xFF4A1D28), // Darker lavender
    tertiaryContainer: Color(0xFFF5E5EB), // Very light lavender
    onTertiaryContainer: Color(0xFF5F2C39), // Darker lavender-pink for text/icons
    error: Color(0xFFB3261E), // Calming soft red
    onError: Color(0xFFFFFFFF), // White text/icons on error
    background: Color(0xFFF5F7FA), // Light gray for background
    onBackground: Color(0xFF4A5568), // Muted gray-blue for text/icons
    surface: Color(0xFFFFFFFF), // White for cards and surfaces
    onSurface: Color(0xFF4A5568), // Muted gray-blue for text/icons
    outline: Color(0xFF94A3B8), // Soft outline for borders
  ),
  // Text theme
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Color(0xFF4A5568)),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w600, color: Color(0xFF4A5568)),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Color(0xFF4A5568)),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF4A5568)),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xFF4A5568)),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFF4A5568)),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF4A5568)),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF718096)),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF94A3B8)),
  ),
  // AppBar theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF6A9FB5), // Matches primary
    foregroundColor: Color(0xFFFFFFFF), // White for text/icons
    elevation: 2,
    centerTitle: true,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
  ),
  // Button theme
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF6A9FB5), // Matches primary
    textTheme: ButtonTextTheme.primary,
  ),
  // ElevatedButton theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6A9FB5), // Matches primary
      foregroundColor: const Color(0xFFFFFFFF), // White text
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  // FloatingActionButton theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF6A9FB5), // Matches primary
    foregroundColor: Color(0xFFFFFFFF), // White icons
  ),
  // Input decoration theme
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF5F7FA), // Light gray
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF94A3B8)), // Outline color
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: Color(0xFF6A9FB5)), // Matches primary
    ),
    labelStyle: TextStyle(color: Color(0xFF4A5568)), // Muted gray-blue
  ),
  // Card theme
  cardTheme: const CardTheme(
    color: Color(0xFFFFFFFF), // White for card backgrounds
    shadowColor: Color(0xFFD1D5DB), // Light shadow
    elevation: 2,
    margin: EdgeInsets.all(8),


// MERRY CHRISTMAS!




  ),
  // TabBar theme
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xFF6A9FB5), // Matches primary
    unselectedLabelColor: Color(0xFF94A3B8), // Muted gray-blue
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFF6A9FB5), width: 2), // Primary color underline
      ),
    ),
  ),
  // Divider theme
  dividerTheme: const DividerThemeData(
    color: Color(0xFFD1D5DB), // Light gray for dividers
    thickness: 1,
  ),
  // Icon theme
  iconTheme: const IconThemeData(
    color: Color(0xFF4A5568), // Muted gray-blue for icons
  ),
),

      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
