class ApiConfig {
  static const bool isProduction = true;

  static String get baseUrl {
    if (isProduction) {
      return 'https://agency-travel-app.onrender.com';
    }

    // URL para modo desarrollo en web
    return 'http://localhost:8080';
  }
}
