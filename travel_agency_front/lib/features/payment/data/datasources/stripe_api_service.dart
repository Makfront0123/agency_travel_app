import 'dart:js_util' as js_util;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as mobile_stripe;
import 'package:stripe_js/stripe_js.dart' as stripe_js;

class StripePaymentApiService {
  Map<String, dynamic>? paymentIntent;

  // Instancia de Stripe JS para Web
  late stripe_js.Stripe? stripeWeb;

  Future<void> initStripe(String publishableKey) async {
    if (kIsWeb) {
      stripeWeb = stripe_js.Stripe(publishableKey);
    } else {
      stripeWeb = null;
    }
  }

  Future<void> processPayment({
    required String amount,
    required String currency,
  }) async {
    if (kIsWeb) {
      if (stripeWeb == null) throw Exception('Stripe JS no inicializado');

      final sessionId = await _createCheckoutSession(amount, currency);

      // Forzamos el cast a dynamic para que js_util acepte la instancia
      await js_util.callMethod(
        stripeWeb! as dynamic,
        'redirectToCheckout',
        [
          js_util.jsify({
            'sessionId': sessionId,
          })
        ],
      );
    } else {
      // Código móvil con flutter_stripe
      paymentIntent = await _createPaymentIntent(amount, currency);

      await mobile_stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: mobile_stripe.SetupPaymentSheetParameters(
          googlePay: const mobile_stripe.PaymentSheetGooglePay(
              merchantCountryCode: 'US'),
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          merchantDisplayName: 'Travel Agency',
        ),
      );

      await _displayPaymentSheet();
    }
  }

  Future<String> _createCheckoutSession(String amount, String currency) async {
    final Dio dio = Dio();
    final secretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? '';

    final response = await dio.post(
      'https://api.stripe.com/v1/checkout/sessions',
      options: Options(
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {
        'payment_method_types[]': 'card',
        'line_items[0][price_data][currency]': currency,
        'line_items[0][price_data][product_data][name]':
            'Compra en Travel Agency',
        'line_items[0][price_data][unit_amount]':
            (double.parse(amount) * 100).toInt(),
        'line_items[0][quantity]': 1,
        'mode': 'payment',
        'success_url': 'https://tu-sitio.com/success',
        'cancel_url': 'https://tu-sitio.com/cancel',
      },
    );

    return response.data['id'] as String;
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await mobile_stripe.Stripe.instance.presentPaymentSheet();
      paymentIntent = null;
    } on mobile_stripe.StripeException catch (e) {
      throw Exception("StripeException: $e");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
      String amount, String currency) async {
    final Dio dio = Dio();
    final secretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? '';

    final body = {
      'amount': _calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
    };

    final response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: body,
    );

    return response.data;
  }

  String _calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }
}
