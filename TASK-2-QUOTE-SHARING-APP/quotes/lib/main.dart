import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:quotes/core/hive/hive_registrar.g.dart';
import 'package:quotes/features/quotes/domain/quote.dart';
import 'features/quotes/presentation/pages/home_page.dart';
import 'features/quotes/presentation/pages/favorites_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<Quote>('favorites_box');
  await Hive.openBox<Quote>('daily_quote_box');
  runApp(const ProviderScope(child:  QuoteApp()));
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote of the Day',
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
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
