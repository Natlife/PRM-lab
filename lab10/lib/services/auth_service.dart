import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _sessionKey = 'user_session';
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel> loginRealApi(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = UserModel(
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        image: data['image'] ?? '',
        token: data['token'] ?? '',
        loginType: 'Real API',
      );
      await saveUserSession(user);
      return user;
    } else {
      final errData = jsonDecode(response.body);
      throw Exception(errData['message'] ?? 'Failed to authenticate');
    }
  }

  Future<UserModel> loginMock(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (username.trim().toLowerCase() == 'admin' && password == 'admin123') {
      final user = UserModel(
        username: 'admin',
        email: 'admin@mockbackend.local',
        firstName: 'Mock',
        lastName: 'Admin',
        image: 'https://robohash.org/mock-admin.png',
        token: 'mock-jwt-token-abcdef123456',
        loginType: 'Mock Login',
      );
      await saveUserSession(user);
      return user;
    } else {
      throw Exception('Invalid mock credentials! (Use admin/admin123)');
    }
  }

  Future<UserModel> loginGoogleReal() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google Sign-In was cancelled by user');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception('Failed to obtain user from Firebase');
    }

    final nameParts = (firebaseUser.displayName ?? 'Google User').split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : 'Google';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'User';

    final user = UserModel(
      username: firebaseUser.email?.split('@').first ?? 'google_user',
      email: firebaseUser.email ?? '',
      firstName: firstName,
      lastName: lastName,
      image: firebaseUser.photoURL ?? 'https://robohash.org/google-user.png',
      token: await firebaseUser.getIdToken() ?? 'google-mock-token',
      loginType: 'Google Sign-In',
    );

    await saveUserSession(user);
    return user;
  }

  Future<UserModel> loginGoogleMock() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final user = UserModel(
      username: 'johndoe_google',
      email: 'johndoe@gmail.com',
      firstName: 'John',
      lastName: 'Doe (Simulated)',
      image: 'https://robohash.org/john-google.png',
      token: 'simulated-google-token-xyz789',
      loginType: 'Google Sign-In (Simulated)',
    );
    await saveUserSession(user);
    return user;
  }

  Future<void> saveUserSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(user.toJson());
    await prefs.setString(_sessionKey, jsonStr);
  }

  Future<UserModel?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_sessionKey);
    if (jsonStr == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(jsonStr));
    } catch (_) {
      return null;
    }
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    try {
      await FirebaseAuth.instance.signOut();
    } catch (_) {}
  }
}
