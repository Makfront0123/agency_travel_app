import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaypalPaymentApiService {
  Future<bool> payWithPayPal({
    required BuildContext context,
    required String amount,
    required String currency,
  }) async {
    final Completer<bool> completer = Completer();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: dotenv.env['PAYPAL_CLIENT_ID']!,
          secretKey: dotenv.env['PAYPAL_SECRET_KEY']!,
          transactions: [
            {
              "amount": {
                "total": amount,
                "currency": currency,
                "details": {
                  "subtotal": amount,
                  "shipping": '0',
                  "shipping_discount": 0,
                },
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "Templates Subscription",
                    "quantity": 1,
                    "price": amount,
                    "currency": currency,
                  }
                ]
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            if (!completer.isCompleted) {
              if (Navigator.canPop(context)) Navigator.pop(context);
              completer.complete(true);
            }
          },
          onError: (error) {
            if (!completer.isCompleted) {
              if (Navigator.canPop(context)) Navigator.pop(context);
              completer.complete(false);
            }
          },
          onCancel: () {
            if (!completer.isCompleted) {
              if (Navigator.canPop(context)) Navigator.pop(context);
              completer.complete(false);
            }
          },
        ),
      ),
    );

    return completer.future;
  }
}
