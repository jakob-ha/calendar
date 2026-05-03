import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../state_providers/event_provider.dart';

Future<void> addEvent(BuildContext context) async {
  final nameController = TextEditingController();

  DateTime? selectedDate;

  if (context.mounted) {
    selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100)
    );
  }

  if (selectedDate == null) return;

  DateTime now = DateTime.now();

  TimeOfDay? startTime;

  if (context.mounted) {
    startTime = await showTimePicker(
      context: context,
      helpText: "Begins at:",
      initialTime: TimeOfDay.fromDateTime(now),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  if (startTime == null) return;

  TimeOfDay? endTime;

  if (context.mounted) {
    endTime = await showTimePicker(
      context: context,
      helpText: "Ends at:",
      initialTime: startTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  if (endTime == null) return;

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