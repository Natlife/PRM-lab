import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/weather_model.dart';

class ApiService {
  static const String _localUrl = 'http://localhost:5001/api/v1/public/posts';
  static const String _emulatorUrl = 'http://10.0.2.2:5001/api/v1/public/posts';
  static const String _fallbackUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(_localUrl)).timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
          final list = decoded['data'] as List;
          return list.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } catch (_) {
      try {
        final response = await http.get(Uri.parse(_emulatorUrl)).timeout(const Duration(seconds: 2));
        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
            final list = decoded['data'] as List;
            return list.map((e) => PostModel.fromJson(e)).toList();
          }
        }
      } catch (_) {}
    }

    final response = await http.get(Uri.parse(_fallbackUrl));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body) as List;
      return decoded.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<PostModel> createPost(String title, String body) async {
    final Map<String, dynamic> requestBody = {
      'userId': 1,
      'title': title,
      'body': body,
    };

    try {
      final response = await http.post(
        Uri.parse(_localUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      ).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
          return PostModel.fromJson(decoded['data']);
        }
      }
    } catch (_) {
      try {
        final response = await http.post(
          Uri.parse(_emulatorUrl),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(requestBody),
        ).timeout(const Duration(seconds: 2));

        if (response.statusCode == 200) {
          final decoded = json.decode(response.body);
          if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
            return PostModel.fromJson(decoded['data']);
          }
        }
      } catch (_) {}
    }

    final response = await http.post(
      Uri.parse(_fallbackUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return PostModel.fromJson(decoded);
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<WeatherModel> fetchWeather(String cityName) async {
    final geoUrl = 'https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeComponent(cityName)}&count=1&language=en&format=json';
    final geoResponse = await http.get(Uri.parse(geoUrl));
    
    if (geoResponse.statusCode != 200) {
      throw Exception('City not found');
    }

    final geoData = json.decode(geoResponse.body);
    final results = geoData['results'] as List?;
    if (results == null || results.isEmpty) {
      throw Exception('City not found');
    }

    final cityInfo = results[0];
    final double lat = cityInfo['latitude'];
    final double lng = cityInfo['longitude'];
    final String resolvedCityName = '${cityInfo['name']}, ${cityInfo['country'] ?? ''}';

    final weatherUrl = 'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m';
    final weatherResponse = await http.get(Uri.parse(weatherUrl));

    if (weatherResponse.statusCode == 200) {
      final weatherData = json.decode(weatherResponse.body);
      return WeatherModel.fromJson(weatherData, resolvedCityName);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
