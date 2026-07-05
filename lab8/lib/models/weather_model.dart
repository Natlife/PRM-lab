class WeatherModel {
  final String cityName;
  final double temperature;
  final double apparentTemperature;
  final int humidity;
  final double windSpeed;
  final int weatherCode;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.apparentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    final current = json['current'] ?? {};
    return WeatherModel(
      cityName: cityName,
      temperature: (current['temperature_2m'] as num?)?.toDouble() ?? 0.0,
      apparentTemperature: (current['apparent_temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (current['relative_humidity_2m'] as num?)?.toInt() ?? 0,
      windSpeed: (current['wind_speed_10m'] as num?)?.toDouble() ?? 0.0,
      weatherCode: (current['weather_code'] as num?)?.toInt() ?? 0,
    );
  }

  String get weatherDescription {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Mainly clear, partly cloudy, and overcast';
      case 45:
      case 48:
        return 'Fog and depositing rime fog';
      case 51:
      case 53:
      case 55:
        return 'Drizzle: Light, moderate, and dense intensity';
      case 61:
      case 63:
      case 65:
        return 'Rain: Slight, moderate, and heavy intensity';
      case 71:
      case 73:
      case 75:
        return 'Snow fall: Slight, moderate, and heavy intensity';
      case 80:
      case 81:
      case 82:
        return 'Rain showers: Slight, moderate, and violent';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm: Slight or moderate';
      default:
        return 'Unknown weather condition';
    }
  }

  String get recommendation {
    if (weatherCode >= 60 && weatherCode <= 67) {
      return 'It is raining. Don\'t forget your umbrella today!';
    } else if (weatherCode >= 80 && weatherCode <= 82) {
      return 'Rain showers expected. Carry a raincoat or umbrella!';
    } else if (weatherCode >= 95) {
      return 'Thunderstorm warning! Better stay indoors and stay safe.';
    } else if (temperature > 32) {
      return 'Very hot outside. Stay hydrated and avoid long outdoor activities.';
    } else if (temperature < 15) {
      return 'Quite chilly. Wear a warm jacket if you go out.';
    } else {
      return 'Beautiful weather! Great day for outdoor activities.';
    }
  }
}
