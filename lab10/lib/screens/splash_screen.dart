import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final bool isFirebaseInitialized;
  const SplashScreen({super.key, required this.isFirebaseInitialized});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await NotificationService.requestPermissions();
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = await _authService.getUserSession();
    if (!mounted) return;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: user,
            isFirebaseInitialized: widget.isFirebaseInitialized,
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            isFirebaseInitialized: widget.isFirebaseInitialized,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF11111B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security_rounded,
              size: 80,
              color: Color(0xFFCBA6F7),
            ),
            SizedBox(height: 24),
            Text(
              'PRM Auth Companion',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Secure Session & Notification Manager',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white38,
              ),
            ),
            SizedBox(height: 48),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCBA6F7)),
            ),
          ],
        ),
      ),
    );
  }
}
