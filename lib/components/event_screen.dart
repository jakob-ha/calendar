

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/event.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _addEvent(context),
                child: const Text('Add Event'),
              ),
              ElevatedButton(
                onPressed: () => _pickFilter(context),
                child: const Text('Filter'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.events.length,
              itemBuilder: (context, index) {
                final event = provider.events[index];

                return Card(
                  child: ListTile(
                    title: Text(event.name),
                    subtitle: Text(
                      '${event.start} - ${event.end}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<EventProvider>().deleteEvent(event);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _addEvent(BuildContext context) async {
  final nameController = TextEditingController();

  DateTime now = DateTime.now();

  final startTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(now),
  );

  if (startTime == null) return;

  TimeOfDay? endTime;

  if (context.mounted) {
    endTime = await showTimePicker(
        context: context,
        initialTime: startTime,
      );
  }

  if (endTime == null) return;

  DateTime? selectedDate;

  if (context.mounted) {
    selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100)
      );
  }

  if (selectedDate == null) return;

  final start = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    startTime.hour,
    startTime.minute,
  );

  final end = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    endTime.hour,
    endTime.minute,
  );

  if (context.mounted) {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Event name'),
            content: TextField(controller: nameController),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  context.read<EventProvider>().addEvent(
                    Event(
                      name: nameController.text,
                      start: start,
                      end: end,
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
  }
}

Future<void> _pickFilter(BuildContext context) async {

  final range = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );

  if (range != null && context.mounted) {
    context.read<EventProvider>().setFilter(range);
  }
}