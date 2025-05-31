import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';

abstract class PaymentState {}

class PaymentInitialState extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<Payment> payments;

  PaymentLoaded(this.payments);
}

class PaymentFailureState extends PaymentState {
  final String message;

  PaymentFailureState(this.message);
}
