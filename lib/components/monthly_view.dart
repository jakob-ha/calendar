import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/holiday.dart';
import '../state_providers/holiday_provider.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  State<MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TableCalendar<Holiday>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),

            eventLoader: (day) {
              final holidays = context.watch<HolidayProvider>().holidays;

              return holidays.where((h) {
                return h.date.year == day.year &&
                    h.date.month == day.month &&
                    h.date.day == day.day;
              }).toList();
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
          ),

          const SizedBox(height: 8),
        ],
      );
  }
}