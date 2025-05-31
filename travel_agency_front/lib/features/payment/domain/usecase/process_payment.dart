import 'package:travel_agency_front/features/payment/domain/repository/payment_repository.dart';

class ProcessPaymentUserCase {
  final PaymentRepository repository;

  ProcessPaymentUserCase(this.repository);

  Future<void> execute(String amount, String currency) async {
    return repository.processPayment(amount, currency);
  }
}
