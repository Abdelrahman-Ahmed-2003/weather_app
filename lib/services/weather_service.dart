import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app/model/model.dart';

class WeatherApi {
  final String _apiKey = 'd8a8fa45fd4b41ff9db141516242209';

  Future<Model> fetchWeather(double latitude, double longitude) async {
    final url = Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=$_apiKey&q=$latitude,$longitude&days=3');

    print('Request URL: $url'); // Log the URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Model.fromJson(data);
      } else if (response.statusCode == 400) {
        print("Bad Requestttttttttttttttttttttttttttttttttt");
        throw Exception('Bad Request: ${response.reasonPhrase}');
      } else {
        throw Exception('Failed to load weather data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      throw Exception('Failed to load weather data');
    }
  }
}

