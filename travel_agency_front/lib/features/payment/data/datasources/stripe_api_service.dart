import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentApiService {
  Map<String, dynamic>? paymentIntent;

  Future<void> processPayment({
    required String amount,
    required String currency,
  }) async {
    try {
      paymentIntent = await _createPaymentIntent(amount, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Travel Agency',
        ),
      );

      await _displayPaymentSheet();
    } catch (err) {
      throw Exception("Payment failed: $err");
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntent = null;
    } on StripeException catch (e) {
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
