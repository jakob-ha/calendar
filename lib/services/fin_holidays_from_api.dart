import 'package:calendar/services/fetch_holidays.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:provider/provider.dart';

import '../models/holiday.dart';
import '../state_providers/holiday_provider.dart';

Future<void> getHolidaysFromAPI(BuildContext context, String countryCode) async {
  final holidays = await fetchHolidays(countryCode);
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