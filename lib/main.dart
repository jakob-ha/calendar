import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/pages/first.dart';
import 'package:calendar/pages/second.dart';
import 'package:calendar/pages/third.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
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
    FirstPage(),
    SecondPage(),
    ThirdPage(),
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
          NavigationDestination(icon: Icon(Icons.looks_one), label: 'First'),
          NavigationDestination(icon: Icon(Icons.looks_two), label: 'Second'),
          NavigationDestination(icon: Icon(Icons.looks_3), label: 'Third'),
        ],
      ),
    );
  }
}