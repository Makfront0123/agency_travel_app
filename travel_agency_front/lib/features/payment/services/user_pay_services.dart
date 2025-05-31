import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class UserPayServices {
  Future<bool> navigatePaypal(BuildContext context) async {
    Completer<bool> completer = Completer();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId:
              "AZnncQH4jDYj5394u7SiQqC30hjw_8MSRM9B865er8psIw-fRnye9A55zoQ2jO5XfwmW5w3m59HHhcO4",
          secretKey:
              "EFsHteQo_FY7QU4UIVXtW0Jls9fWn7mrwO6kSKQKE0jMfJQtnDtsYnzZRCwiT6jz1rgdhskUbkI1keRy",
          transactions: const [
            {
              "amount": {
                "total": '3',
                "currency": "USD",
                "details": {
                  "subtotal": '3',
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "Templates Suscription",
                    "quantity": 1,
                    "price": '3',
                    "currency": "USD"
                  }
                ]
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            Navigator.pop(context);
            completer.complete(true); // 👈 pago exitoso
          },
          onError: (error) {
            Navigator.pop(context);
            completer.complete(false); // 👈 error en pago
          },
          onCancel: () {
            Navigator.pop(context);
            completer.complete(false); // 👈 pago cancelado
          },
        ),
      ),
    );

    return completer.future;
  }
}
