import 'package:calendar/state_providers/app_state.dart';
import 'package:calendar/state_providers/event_provider.dart';
import 'package:calendar/state_providers/holiday_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/pages/home_page.dart';
import 'package:calendar/pages/calendar_page.dart';
import 'package:calendar/pages/settings_page.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppState()),
          ChangeNotifierProvider(create: (_) => EventProvider()),
          ChangeNotifierProvider(create: (_) => HolidayProvider()),
        ],
        child: const MyApp(),
      )
  );
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
    context.read<HolidayProvider>().loadHolidays();

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() => index = i);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}