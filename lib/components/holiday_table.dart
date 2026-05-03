import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/holiday.dart';
import '../state_providers/holiday_provider.dart';

import '../utils/add_holiday.dart';

class HolidayTable extends StatefulWidget {
  const HolidayTable({super.key});

  @override
  State<HolidayTable> createState() => _HolidayTableState();
}

class _HolidayTableState extends State<HolidayTable> {
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


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final events = context.watch<HolidayProvider>().holidays;
    if (_selectedDay != null) {
      _selectedHolidays.value = events
          .where((h) => isSameDay(h.date, _selectedDay))
          .toList();
    }
  }

  List<Holiday> _getHolidaysForDay(DateTime day) {
    return context.read<HolidayProvider>().holidays.where((h) => isSameDay(h.date, day)).toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => addHoliday(context),
                child: const Text('Add Holiday'),
              ),
            ],
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
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<HolidayProvider>().deleteHoliday(value[index]);
                          },
                        ),
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