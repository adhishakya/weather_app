class TemperatureInfo {
  final double temperature;
  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json["temp"];
    return TemperatureInfo(temperature: temperature);
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json["description"];
    final icon = json["icon"];
    return WeatherInfo(description: description, icon: icon);
  }
}

class WeatherResponse {
  final String city;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  WeatherResponse({
    required this.city,
    required this.tempInfo,
    required this.weatherInfo,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final city = json["name"];

    final mainTemperature = json["main"];
    final finalTemperature = TemperatureInfo.fromJson(mainTemperature);

    final weatherInfoJson = json["weather"][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    return WeatherResponse(
      city: city,
      tempInfo: finalTemperature,
      weatherInfo: weatherInfo,
    );
  }
}
