import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  String stripeKey = '';

  if (kIsWeb) {
    stripeKey = const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');
  } else {
    try {
      await dotenv.load(fileName: ".env");
      stripeKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
    } catch (e) {
      throw Exception('Error loading .env file: $e');
    }
  }

  Stripe.publishableKey = stripeKey;
  await Stripe.instance.applySettings();

  await initializeDateFormatting('es_ES', null);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
