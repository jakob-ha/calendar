import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/holiday.dart';
import '../state_providers/holiday_provider.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  late final ValueNotifier<List<Holiday>> _selectedHolidays;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedHolidays = ValueNotifier(_getHolidaysForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedHolidays.dispose();
    super.dispose();
  }

  List<Holiday> _getHolidaysForDay(DateTime day) {
    // Implementation example
    return context.read<HolidayProvider>().holidays ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TableCalendar<Holiday>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),

            startingDayOfWeek: StartingDayOfWeek.monday,

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
                _focusedDay = focusedDay;
              });
              _selectedHolidays.value = _getHolidaysForDay(selectedDay);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),

          const SizedBox(height: 8),

          Expanded(
            child: ValueListenableBuilder<List<Holiday>>(
              valueListenable: _selectedHolidays,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
  }
}