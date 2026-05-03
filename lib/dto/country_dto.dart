class CountryDTO {
  final String countryCode;
  final String name;

  CountryDTO({
    required this.countryCode,
    required this.name
  });

  factory CountryDTO.fromJson(Map<String, dynamic> json) {
    return CountryDTO(
      countryCode: json['countryCode'],
      name: json['name'],
    );
  }
}