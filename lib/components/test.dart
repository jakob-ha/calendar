import 'package:flutter/material.dart';

import '../dto/holiday_dto.dart';
import '../services/fetch_holidays.dart';

class FetchingDemo extends StatelessWidget {
  const FetchingDemo({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<HolidayDTO>>(
      future: fetchHolidays(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No holidays found');
        }

        final holidays = snapshot.data!;

        return ListView.builder(
          itemCount: holidays.length,
          itemBuilder: (context, index) {
            final holiday = holidays[index];
            return ListTile(
              title: Text(holiday.name),
              subtitle: Text(holiday.date.toIso8601String()),
            );
          },
        );
      },
    );
  }
}