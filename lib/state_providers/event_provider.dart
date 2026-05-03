import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/event.dart';

class EventProvider extends ChangeNotifier {
  static const _storageKey = 'events';
  final List<Event> _events = [];
  DateTimeRange? _filterRange;

  List<Event> get events {
    if (_filterRange == null) return [..._events];

    return _events.where((event) {
      return event.start.isAfter(_filterRange!.start) &&
          event.start.isBefore(_filterRange!.end);
    }).toList();
  }

  void addEvent(Event event) {
    _events.add(event);
    _saveEvents();
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    _saveEvents();
    notifyListeners();
  }

  Future<void> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);

    if (data != null) {
      final List decoded = json.decode(data);
      _events.clear();
      _events.addAll(
        decoded.map((e) => Event.fromJson(e)).toList(),
      );
      notifyListeners();
    }
  }

  Future<void> _saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(
      _events.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_storageKey, data);
  }
}