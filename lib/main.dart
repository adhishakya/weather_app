import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/date_time_model.dart';
import 'package:weather_app/date_time_service.dart';
import 'package:weather_app/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Default City
  @override
  void initState() {
    super.initState();
    _searchCity("Kathmandu");
  }

  @override
  void dispose() {
    _cityName.dispose();
    super.dispose();
  }

  final TextEditingController _cityName = TextEditingController();

  final _dataService = DataService();

  final _dateAndTimeService = DateAndTimeService();

  WeatherResponse? _response;

  DateAndTimeResponse? _dateAndTimeResponse;

  String? fullTime;
  String? hour;

  String backgroundImageStatus = "";

  void _searchCity(String city) async {
    final response = await _dataService.getWeather(city);

    setState(() {
      _response = response;
    });

    final dateAndTimeResponse = await _dateAndTimeService.getDateAndTime(
      response.coordinatesInfo.latitude,
      response.coordinatesInfo.longitude,
    );

    setState(() {
      _dateAndTimeResponse = dateAndTimeResponse;
      fullTime = _dateAndTimeResponse?.time;
      hour = fullTime?.substring(11, 13);
      int hourInt = int.parse(hour!);
      print(hourInt);
      print(hourInt.runtimeType);
      // print(_dateAndTimeResponse?.time);
      // print(response.city);
      // print(response.tempInfo.temperature);
      // print(response.weatherInfo.description);
      // print(response.coordinatesInfo.longitude);
      if (hourInt >= 05 && hourInt <= 11) {
        backgroundImageStatus = "assets/morning.jpg";
      } else if (hourInt >= 12 && hourInt <= 17) {
        backgroundImageStatus = "assets/noon.jpg";
      } else {
        backgroundImageStatus = "assets/night.jpg";
      }
      print(backgroundImageStatus);
    });
  }

  void onSearchButtonPress() {
    _searchCity(_cityName.text);
    DateAndTimeService();
    _cityName.clear();
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImageStatus.toString()),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 44,
              left: 40,
              right: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (String _) {
                          onSearchButtonPress();
                        },
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        controller: _cityName,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "City Name",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              onSearchButtonPress();
                            },
                            iconSize: 36,
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${_response?.city}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "${_response?.tempInfo.temperature}°",
                    style: const TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${_response?.weatherInfo.description[0].toUpperCase()}${_response?.weatherInfo.description.substring(1)}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 470),
                      child: Text(
                        "${_dateAndTimeResponse?.time}",
                        style: const TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
