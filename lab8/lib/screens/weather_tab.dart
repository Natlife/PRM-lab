import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/api_service.dart';

class WeatherTab extends StatefulWidget {
  const WeatherTab({super.key});

  @override
  State<WeatherTab> createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController(text: 'Hanoi');
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final city = _searchController.text.trim();
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final weather = await _apiService.fetchWeather(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  IconData _getWeatherIcon(int code) {
    if (code == 0) {
      return Icons.wb_sunny_rounded;
    } else if (code >= 1 && code <= 3) {
      return Icons.wb_cloudy_rounded;
    } else if (code == 45 || code == 48) {
      return Icons.blur_on_rounded;
    } else if (code >= 51 && code <= 55) {
      return Icons.grain_rounded;
    } else if (code >= 61 && code <= 65) {
      return Icons.umbrella_rounded;
    } else if (code >= 71 && code <= 75) {
      return Icons.ac_unit_rounded;
    } else if (code >= 80 && code <= 82) {
      return Icons.umbrella_rounded;
    } else if (code >= 95) {
      return Icons.thunderstorm_rounded;
    }
    return Icons.help_outline_rounded;
  }

  Color _getWeatherColor(int code) {
    if (code == 0) {
      return const Color(0xFFF9E2AF);
    } else if (code >= 1 && code <= 3) {
      return const Color(0xFFBAC2DE);
    } else if (code >= 60 && code <= 67) {
      return const Color(0xFF89B4FA);
    } else if (code >= 80 && code <= 82) {
      return const Color(0xFF89B4FA);
    } else if (code >= 95) {
      return const Color(0xFFF38BA8);
    }
    return const Color(0xFFCBA6F7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11111B),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2E),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter city name...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        prefixIcon: const Icon(Icons.search_rounded, color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      ),
                      onSubmitted: (_) => _fetchWeather(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBA6F7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _fetchWeather,
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF11111B),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 80.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCBA6F7)),
                  ),
                ),
              )
            else if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF313244),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_off_rounded,
                        color: Color(0xFFF38BA8),
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Search Failed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _fetchWeather,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCBA6F7),
                        foregroundColor: const Color(0xFF1E1E2E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else if (_weather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1E1E2E),
                          const Color(0xFF313244).withOpacity(0.4),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _weather!.cityName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Icon(
                          _getWeatherIcon(_weather!.weatherCode),
                          size: 72,
                          color: _getWeatherColor(_weather!.weatherCode),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${_weather!.temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 54,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _weather!.weatherDescription,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _getWeatherColor(_weather!.weatherCode).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getWeatherColor(_weather!.weatherCode).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: _getWeatherColor(_weather!.weatherCode),
                          size: 24,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recommendation',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getWeatherColor(_weather!.weatherCode),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _weather!.recommendation,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailCard(
                          title: 'Feels Like',
                          value: '${_weather!.apparentTemperature.toStringAsFixed(1)}°C',
                          icon: Icons.thermostat_rounded,
                          color: const Color(0xFFFAB387),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDetailCard(
                          title: 'Humidity',
                          value: '${_weather!.humidity}%',
                          icon: Icons.water_drop_rounded,
                          color: const Color(0xFF74C7EC),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDetailCard(
                          title: 'Wind Speed',
                          value: '${_weather!.windSpeed.toStringAsFixed(1)} km/h',
                          icon: Icons.air_rounded,
                          color: const Color(0xFFA6E3A1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.4),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
