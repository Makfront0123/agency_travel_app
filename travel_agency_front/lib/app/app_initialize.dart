import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as mobile_stripe;
import 'package:intl/date_symbol_data_local.dart';
import 'package:stripe_js/stripe_js.dart' as web_stripe;

web_stripe.Stripe? stripeWeb;

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }

  String stripeKey;

  if (kIsWeb) {
    // Para web, usa dart-define, no dotenv
    stripeKey = const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY',
        defaultValue: '');
    stripeWeb = web_stripe.Stripe(stripeKey);
  } else {
    stripeKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';
    mobile_stripe.Stripe.publishableKey = stripeKey;
    await mobile_stripe.Stripe.instance.applySettings();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await initializeDateFormatting('es_ES', null);
}
