
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

  @override
  String toString() => '$name from ${DateFormat('HH:mm').format(start)} to ${DateFormat('HH:mm').format(end)}';
}