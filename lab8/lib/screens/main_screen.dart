import 'package:flutter/material.dart';
import 'post_tab.dart';
import 'weather_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const PostTab(),
    const WeatherTab(),
  ];

  final List<String> _titles = [
    'Feed Board',
    'Weather Companion',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11111B),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E1E2E),
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white10,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF1E1E2E),
          selectedItemColor: const Color(0xFFCBA6F7),
          unselectedItemColor: Colors.white38,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.forum_rounded),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_rounded),
              label: 'Weather',
            ),
          ],
        ),
      ),
    );
  }
}
