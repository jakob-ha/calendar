import 'package:flutter/material.dart';

import '../models/event.dart';

class EventProvider extends ChangeNotifier {
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
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void setFilter(DateTimeRange? range) {
    _filterRange = range;
    notifyListeners();
  }
}