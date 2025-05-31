import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/payment/data/datasources/payment_api_service.dart';
import 'package:travel_agency_front/features/payment/data/datasources/paypal_api_service.dart';
import 'package:travel_agency_front/features/payment/data/datasources/stripe_api_service.dart';
import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';
import 'package:travel_agency_front/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final StripePaymentApiService stripePaymentApiService;
  final PaypalPaymentApiService paypalPaymentApiService;
  final PaymentApiService paymentRepository;

  PaymentRepositoryImpl(
    this.stripePaymentApiService,
    this.paypalPaymentApiService,
    this.paymentRepository,
  );

  @override
  Future<void> processPayment(String amount, String currency) async {
    return stripePaymentApiService.processPayment(
      amount: amount,
      currency: currency,
    );
  }

  @override
  Future<bool> processPaymentWithPayPal(
    BuildContext context,
    String amount,
    String currency,
  ) async {
    final success = await paypalPaymentApiService.payWithPayPal(
      context: context,
      amount: amount,
      currency: currency,
    );
    return success;
  }

  @override
  Future<Payment> addPayment(Payment payment, String token) async {
    return paymentRepository.registerPayment(payment, token);
  }
}
