import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/main.dart';

import '../state_providers/app_state.dart';

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