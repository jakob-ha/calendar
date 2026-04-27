class DateFormat {
  String monthNumberToString(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];

    if (month < 1 || month > 12) {
      throw ArgumentError("Invalid month: $month");
    }

    return months[month - 1];
  }
}