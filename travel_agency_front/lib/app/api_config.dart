import 'dart:io';

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Detecta si está corriendo en un emulador
      final isEmulator = _isRunningOnEmulator();
      return isEmulator
          ? 'http://10.0.2.2:8080' // Emulador Android accede al host así
          : 'http://192.168.1.89:8080'; // IP local de tu PC
    } else if (Platform.isIOS) {
      return 'http://localhost:8080'; // iOS emulador puede usar localhost
    } else {
      return 'http://192.168.1.89:8080'; // fallback para otros entornos
    }
  }

  static bool _isRunningOnEmulator() {
    return !Platform.environment.containsKey("ANDROID_STORAGE");
  }
}


/*
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
 */

/*
import 'dart:io';

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Detecta si está corriendo en un emulador
      final isEmulator = _isRunningOnEmulator();
      return isEmulator
          ? 'http://10.0.2.2:8080' // Emulador Android accede al host así
          : 'http://192.168.1.89:8080'; // IP local de tu PC
    } else if (Platform.isIOS) {
      return 'http://localhost:8080'; // iOS emulador puede usar localhost
    } else {
      return 'http://192.168.1.89:8080'; // fallback para otros entornos
    }
  }

  static bool _isRunningOnEmulator() {
    return !Platform.environment.containsKey("ANDROID_STORAGE");
  }
}
 */