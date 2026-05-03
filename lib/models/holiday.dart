class Holiday {
  final String name;
  final DateTime date;

  Holiday({
    required this.name,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date.toIso8601String(),
  };

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      name: json['name'],
      date: DateTime.parse(json['date']),
    );
  }

  @override
  String toString() => name;
}