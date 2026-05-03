
import 'package:intl/intl.dart';

class Event {
  final String name;
  final DateTime start;
  final DateTime end;

  Event({
    required this.name,
    required this.start,
    required this.end,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'start': start.toIso8601String(),
    'end': end.toIso8601String(),
  };

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }

  @override
  String toString() =>
      '$name from ${DateFormat('HH:mm').format(start)} to ${DateFormat('HH:mm').format(end)}';
}