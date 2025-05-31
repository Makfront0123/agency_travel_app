import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';

abstract class PaymentRepository {
  Future<void> processPayment(String amount, String currency);
  Future<bool> processPaymentWithPayPal(
    BuildContext context,
    String amount,
    String currency,
  );

  Future<void> addPayment(Payment payment, String token);
}
