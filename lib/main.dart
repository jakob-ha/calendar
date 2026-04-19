import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class SharedHeader extends StatelessWidget {
  const SharedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.watch<AppState>().sharedText;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text.isEmpty ? 'No text submitted yet' : text,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Column(
        children: [
          const SharedHeader(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AppState>().updateText(controller.text);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Big'),
              Tab(text: 'Medium'),
              Tab(text: 'Small'),
            ],
          ),
        ),
        body: const Column(
          children: [
            SharedHeader(),
            Expanded(
              child: TabBarView(
                children: [
                  ItemList(fontSize: 24),
                  ItemList(fontSize: 16),
                  ItemList(fontSize: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final double fontSize;

  const ItemList({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Stack(
      children: [
        Center(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];

              return ListTile(
                title: Text(
                  item,
                  style: TextStyle(fontSize: fontSize),
                  textAlign: TextAlign.center,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<AppState>().removeItem(item);
                  },
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showAddDialog(context),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Item'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Enter text',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppState>().addItem(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isDark = state.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Third Page')),
      body: Column(
        children: [
          const SharedHeader(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (value) {
              context.read<AppState>().toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}