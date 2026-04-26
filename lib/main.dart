import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/pages/home_page.dart';
import 'package:calendar/pages/events_page.dart';
import 'package:calendar/pages/settings_page.dart';

import 'models/event.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppState()),
          ChangeNotifierProvider(create: (_) => EventProvider()),
        ],
        child: const MyApp(),
      )

  );
}

class AppState extends ChangeNotifier {
  String sharedText = '';
  final List<String> items = [];
  ThemeMode themeMode = ThemeMode.light;

  void updateText(String text) {
    sharedText = text;
    notifyListeners();
  }

  void addItem(String item) {
    if (item.trim().isEmpty) return;
    items.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    items.remove(item);
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  DateTimeRange? _filterRange;

  List<Event> get events {
    if (_filterRange == null) return [..._events];

    return _events.where((event) {
      return event.start.isAfter(_filterRange!.start) &&
          event.start.isBefore(_filterRange!.end);
    }).toList();
  }

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void setFilter(DateTimeRange? range) {
    _filterRange = range;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: state.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final pages = const [
    HomePage(),
    EventsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() => index = i);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.looks_3), label: 'Third'),
        ],
      ),
    );
  }
}