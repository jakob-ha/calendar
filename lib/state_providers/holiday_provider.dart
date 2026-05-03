import 'package:calendar/models/holiday.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HolidayProvider extends ChangeNotifier {
  static const _storageKey = 'holidays';
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
    _saveHolidays();
    notifyListeners();
  }

  void deleteHoliday(Holiday holiday) {
    _holidays.remove(holiday);
    _saveHolidays();
    notifyListeners();
  }

  Future<void> loadHolidays() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);

    if (data != null) {
      final List decoded = json.decode(data);
      _holidays.clear();
      _holidays.addAll(
        decoded.map((e) => Holiday.fromJson(e)).toList(),
      );
      notifyListeners();
    }
  }

  Future<void> _saveHolidays() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(
      _holidays.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_storageKey, data);
  }
}