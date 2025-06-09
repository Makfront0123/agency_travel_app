import 'dart:io';

class ApiConfig {
  static const bool isProduction = true;

  static String get baseUrl {
    if (isProduction) {
      return 'https://agency-travel-app.onrender.com';
    }

    if (Platform.isAndroid) {
      final isEmulator = _isRunningOnEmulator();
      return isEmulator ? 'http://10.0.2.2:8080' : 'http://192.168.1.89:8080';
    } else if (Platform.isIOS) {
      return 'http://localhost:8080';
    } else {
      return 'http://192.168.1.89:8080';
    }
  }

  static bool _isRunningOnEmulator() {
    return !Platform.environment.containsKey("ANDROID_STORAGE");
  }
}
