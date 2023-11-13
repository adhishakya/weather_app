import 'package:flutter/material.dart';
import 'package:weather_app/data_service.dart';
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

  WeatherResponse? _response;

  void _searchCity(String city) async {
    final response = await _dataService.getWeather(city);
    setState(() {
      _response = response;
    });
    // print(response.city);
    // print(response.tempInfo.temperature);
    // print(response.weatherInfo.description);
  }

  void onSearchButtonPress() {
    _searchCity(_cityName.text);
    _cityName.clear();
    FocusScope.of(context).requestFocus(
      FocusNode(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/night.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
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
                        decoration: InputDecoration(
                          labelText: "City Name",
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          border: const OutlineInputBorder(),
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
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(children: [
                    if (_response != null)
                      Text("${_response?.tempInfo.temperature} °C"),
                    Text("${_response?.city}"),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
