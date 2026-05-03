import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dto/country_dto.dart';

Future<List<CountryDTO>> fetchCountries() async {
  final url = Uri.parse(
    'https://date.nager.at//api/v3/AvailableCountries',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    return data
        .map((json) => CountryDTO.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load countries');
  }
}