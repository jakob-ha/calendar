import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/holiday.dart';

class MonthlyView extends StatefulWidget {
  const MonthlyView({super.key});

  @override
  State<MonthlyView> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends State<MonthlyView> {
  late final Map<DateTime, List<Holiday>> _holidaysMap;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<Holiday> holidays = [
    Holiday(name: "New Year", date: DateTime(2026, 1, 1)),
    Holiday(name: "My Birthday", date: DateTime(2026, 5, 10)),
    Holiday(name: "Christmas", date: DateTime(2026, 12, 25)),
  ];

  @override
  void initState() {
    super.initState();
    _holidaysMap = _groupHolidays(holidays);
  }

  Map<DateTime, List<Holiday>> _groupHolidays(List<Holiday> holidays) {
    final map = <DateTime, List<Holiday>>{};
    for (var h in holidays) {
      final key = _normalize(h.date);
      map.putIfAbsent(key, () => []).add(h);
    }
    return map;
  }

  DateTime _normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  List<Holiday> _getHolidaysForDay(DateTime day) {
    return _holidaysMap[_normalize(day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Holiday Calendar")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getHolidaysForDay,
          ),

          const SizedBox(height: 8),

          // List holidays for selected day
          ..._getHolidaysForDay(_selectedDay ?? _focusedDay)
              .map((h) => ListTile(
            title: Text(h.name),
            subtitle: Text(h.date.toString()),
          )),
        ],
      ),
    );
  }
}