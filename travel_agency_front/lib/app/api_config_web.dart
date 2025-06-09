class ApiConfig {
  static const bool isProduction = true;

  static String get baseUrl {
    // Siempre usa producción en web o puedes poner URL local si quieres.
    return 'https://agency-travel-app.onrender.com';
  }
}
