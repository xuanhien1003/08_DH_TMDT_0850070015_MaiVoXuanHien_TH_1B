import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final String apiKey = '1b77482d4fed24f8ecd5b484d6646b59';
  final cityController = TextEditingController();
  String city = '';
  String weather = '';
  double temperature = 0.0;

  void fetchWeatherData() async {
    final cityName = cityController.text;
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        city = jsonData['name'];
        weather = jsonData['weather'][0]['description'];
        temperature = jsonData['main']['temp'] - 273.15; // Convert temperature from Kelvin to Celsius
      });
    } else {
      setState(() {
        city = 'City not found';
        weather = '';
        temperature = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thời tiết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Nhập khu vực mong muốn',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchWeatherData,
              child: const Text('Tìm kiếm'),
            ),
            const SizedBox(height: 16),
            Text(
              'Thành phố: $city',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              'Thời tiết: $weather',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              'Nhiệt độ: ${temperature.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

