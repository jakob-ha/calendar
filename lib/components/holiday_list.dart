import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/holiday.dart';
import '../services/fetch_holidays.dart';
import '../services/holidays_from_api_by_countrycode.dart';
import '../state_providers/holiday_provider.dart';
import '../utils/add_holiday.dart';
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
                onPressed: () => getHolidaysFromAPI(context, "AX"),
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