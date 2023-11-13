import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    await dotenv.load();

    final String? appId = dotenv.env['APP_ID'];

    final queryParameters = {
      'q': city,
      'appid': appId,
      'units': 'metric',
    };

    final uri = Uri.https(
      "api.openweathermap.org",
      "/data/2.5/weather",
      queryParameters,
    );

    final response = await http.get(uri);
    // print(response.body);

    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
