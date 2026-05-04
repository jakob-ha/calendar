import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/holiday.dart';
import '../state_providers/holiday_provider.dart';

Future<void> addHoliday(BuildContext context) async {
  final nameController = TextEditingController();

  DateTime? selectedDate;

  if (context.mounted) {
    selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        locale: const Locale('en', 'GB'),
    );
  }

  if (selectedDate == null) return;


  final date = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );

  if (context.mounted) {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Holiday name'),
          content: TextField(controller: nameController),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                context.read<HolidayProvider>().addHoliday(
                  Holiday(
                    name: nameController.text,
                    date: date,
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