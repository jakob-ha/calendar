class HolidayDTO {
  final DateTime date;
  final String localName;
  final String name;
  final String countryCode;
  final bool fixed;
  final bool global;
  final List<String>? counties;
  final int? launchYear;
  final List<String> types;

  HolidayDTO({
    required this.date,
    required this.localName,
    required this.name,
    required this.countryCode,
    required this.fixed,
    required this.global,
    required this.counties,
    required this.launchYear,
    required this.types,
  });

  factory HolidayDTO.fromJson(Map<String, dynamic> json) {
    return HolidayDTO(
      date: DateTime.parse(json['date']),
      localName: json['localName'],
      name: json['name'],
      countryCode: json['countryCode'],
      fixed: json['fixed'],
      global: json['global'],
      counties: json['counties'] != null
          ? List<String>.from(json['counties'])
          : null,
      launchYear: json['launchYear'],
      types: List<String>.from(json['types']),
    );
  }
}