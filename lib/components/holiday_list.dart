import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/holiday.dart';
import '../services/fetch_holidays.dart';
import '../state_providers/event_provider.dart';
import '../state_providers/holiday_provider.dart';
import '../utils/date_format.dart';

class HolidayList extends StatelessWidget {
  const HolidayList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HolidayProvider>();
    final DateFormat dateFormat = DateFormat();

    return Scaffold(
      appBar: AppBar(title: const Text('Holidays')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _addHoliday(context),
                child: const Text('Add Holiday'),
              ),
              ElevatedButton(
                onPressed: () => _pickFilter(context),
                child: const Text('Filter dates'),
              ),
              ElevatedButton(
                onPressed: () => _getHolidaysFromAPI(context),
                child: const Text('API'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.holidays.length,
              itemBuilder: (context, index) {
                final holiday = provider.holidays[index];

                return Card(
                  child: ListTile(
                    title: Text(holiday.name),
                    subtitle: Text(
                      '${holiday.date.day} ${dateFormat.monthNumberToString(holiday.date.month)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<HolidayProvider>().deleteHoliday(holiday);
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

Future<void> _addHoliday(BuildContext context) async {
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

Future<void> _pickFilter(BuildContext context) async {

  final range = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );

  if (range != null && context.mounted) {
    context.read<HolidayProvider>().setFilter(range);
  }
}

Future<void> _getHolidaysFromAPI(BuildContext context) async {
  final holidays = await fetchHolidays();
  for (var o in holidays) {
    if (context.mounted) {
      context.read<HolidayProvider>().addHoliday(
            Holiday(
              name: o.name,
              date: o.date,
            ),
          );
    }
  }
}