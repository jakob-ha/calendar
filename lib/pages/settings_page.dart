import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/components/shared_header.dart';

import '../state_providers/app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isDark = state.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings Page')),
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