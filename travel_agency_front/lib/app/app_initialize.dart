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

  await dotenv.load(fileName: ".env");

  String stripeKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  if (kIsWeb) {
    stripeWeb = web_stripe.Stripe(stripeKey);
  } else {
    mobile_stripe.Stripe.publishableKey = stripeKey;
    await mobile_stripe.Stripe.instance.applySettings();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  await initializeDateFormatting('es_ES', null);
}
