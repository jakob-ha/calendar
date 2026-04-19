import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar/main.dart';

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