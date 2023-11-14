class DateAndTimeResponse {
  final String time;

  DateAndTimeResponse({
    required this.time,
  });

  factory DateAndTimeResponse.fromJson(Map<String, dynamic> json) {
    final time = json["formatted"];

    return DateAndTimeResponse(time: time);
  }
}
