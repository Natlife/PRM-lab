import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/notification_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  final bool isFirebaseInitialized;
  const HomeScreen({super.key, required this.user, required this.isFirebaseInitialized});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  bool _isLoggingOut = false;

  Future<void> _handleLogout() async {
    setState(() {
      _isLoggingOut = true;
    });

    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    await _authService.clearUserSession();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: const Text('Successfully logged out!'),
        backgroundColor: const Color(0xFFA6E3A1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          isFirebaseInitialized: widget.isFirebaseInitialized,
        ),
      ),
    );
  }

  Future<void> _triggerTestNotification() async {
    await NotificationService.showNotification(
      'Manual Test Notification',
      'This local notification was triggered manually from the Home Screen.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11111B),
      appBar: AppBar(
        title: const Text(
          'Security Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1E2E),
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 54,
                    backgroundColor: const Color(0xFFCBA6F7).withOpacity(0.15),
                    backgroundImage: NetworkImage(widget.user.image),
                    onBackgroundImageError: (_, __) {},
                    child: widget.user.image.isEmpty
                        ? const Icon(Icons.person_rounded, size: 54, color: Color(0xFFCBA6F7))
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${widget.user.firstName} ${widget.user.lastName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '@${widget.user.username}',
                    style: const TextStyle(
                      color: Color(0xFFCBA6F7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Session Type: ${widget.user.loginType}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account details',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(Icons.email_outlined, 'Email Address', widget.user.email),
                  const Divider(color: Colors.white10, height: 24),
                  _buildDetailRow(
                    Icons.vpn_key_outlined,
                    'JWT Token',
                    widget.user.token.length > 30
                        ? '${widget.user.token.substring(0, 30)}...'
                        : widget.user.token,
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  _buildDetailRow(
                    Icons.cloud_done_outlined,
                    'Firebase Engine',
                    widget.isFirebaseInitialized ? 'Initialized (Production)' : 'Mock (Simulation)',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _triggerTestNotification,
              icon: const Icon(Icons.notifications_active_rounded),
              label: const Text('Trigger Test Notification', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCBA6F7).withOpacity(0.15),
                foregroundColor: const Color(0xFFCBA6F7),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoggingOut ? null : _handleLogout,
              icon: const Icon(Icons.logout_rounded),
              label: _isLoggingOut
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Log Out Session', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF38BA8),
                foregroundColor: const Color(0xFF11111B),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
