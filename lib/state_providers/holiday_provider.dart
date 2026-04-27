import 'package:calendar/models/holiday.dart';
import 'package:flutter/material.dart';

class HolidayProvider extends ChangeNotifier {
  final List<Holiday> _holidays = [];
  DateTimeRange? _filterRange;

  List<Holiday> get holidays {
    if (_filterRange == null) return [..._holidays];

    return _holidays.where((holiday) {
      return holiday.date.isAfter(_filterRange!.start) &&
          holiday.date.isBefore(_filterRange!.end);
    }).toList();
  }

  void addHoliday(Holiday holiday) {
    _holidays.add(holiday);
    notifyListeners();
  }

  void deleteHoliday(Holiday holiday) {
    _holidays.remove(holiday);
    notifyListeners();
  }

  void setFilter(DateTimeRange? range) {
    _filterRange = range;
    notifyListeners();
  }
}