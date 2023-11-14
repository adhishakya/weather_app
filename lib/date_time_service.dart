import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/date_time_model.dart';

class DateAndTimeService {
  Future<DateAndTimeResponse> getDateAndTime(double lat, double lon) async {
    await dotenv.load();

    final String? dateId = dotenv.env["DATE_ID"];

    final queryParameters = {
      'key': dateId,
      'format': 'json',
      'by': 'position',
      'lat': lat.toString(),
      'lng': lon.toString(),
    };

    final uri = Uri.https(
      "api.timezonedb.com",
      "/v2.1/get-time-zone",
      queryParameters,
    );

    final response = await http.get(uri);

    final json = jsonDecode(response.body);

    return DateAndTimeResponse.fromJson(json);
  }
}
