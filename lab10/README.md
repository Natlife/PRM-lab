# Lab 10: Authentication, Session Management & Notifications

This project implements all parts of Lab 10 in a single integrated, production-ready mobile application. It covers:
- **Lab 10.1 (Mock Login)**: Form validation and local authentication simulation.
- **Lab 10.2 (Real REST API Login)**: Remote authentication using HTTP requests to DummyJSON.
- **Lab 10.3 (Auto Login & Logout)**: Session management with SharedPreferences and startup splash routing.
- **Lab 10.4 (Firebase Authentication)**: Google Sign-In with automated simulation fallback if Firebase is not configured on the local system.
- **Lab 10.5 (Local Notification)**: System notification integration triggered upon authentication and via manual button events.

---

## Credentials for Testing

### 1. Real API Login (DummyJSON)
To test the real REST API login, select the **Real API** tab on the Login Screen and enter:
- **Username**: `emilys`
- **Password**: `emilyspass`

### 2. Mock Login
To test the mock backend database login, select the **Mock DB** tab on the Login Screen and enter:
- **Username**: `admin`
- **Password**: `admin123`

### 3. Google Sign-In
To test the Google Sign-In, click the **Google Sign In** button.
- If Firebase is not fully configured (missing `google-services.json` or SHA-1 fingerprints), the app will display **Google Sign In (Simulated)** and log you in using a pre-configured mock Google Account profile.

---

## How to Run the App

1. Fetch and install dependencies:
   ```bash
   flutter pub get
   ```
2. Launch an emulator or connect a physical device.
3. Start the application:
   ```bash
   flutter run
   ```
