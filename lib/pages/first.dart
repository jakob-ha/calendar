import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/main.dart';

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
                labelText: 'Enter name',
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