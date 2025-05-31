import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';

class PaymentModel extends Payment {
  PaymentModel({
    required super.amount,
    super.currency,
    required super.paymentDate,
    required super.status,
    required super.paymentMode,
    required super.reservationId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      amount: json['total'] as double,
      paymentDate: json['paymentDate'] as String,
      status: json['status'] as String,
      paymentMode: json['paymentMode'] as String,
      reservationId: json['reservationId'] as String,
    );
  }
}
