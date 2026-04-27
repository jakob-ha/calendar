import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dto/holiday_dto.dart';

Future<List<HolidayDTO>> fetchHolidays() async {
  final url = Uri.parse(
    'https://date.nager.at/api/v3/PublicHolidays/2026/FI',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data
        .map((json) => HolidayDTO.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load holidays');
  }
}