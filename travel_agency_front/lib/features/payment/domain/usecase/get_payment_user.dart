import 'package:travel_agency_front/features/payment/domain/entities/payment.dart';
import 'package:travel_agency_front/features/payment/domain/repository/payment_repository.dart';

class GetPaymentUserUsecase {
  final PaymentRepository repository;

  GetPaymentUserUsecase(this.repository);

  Future<List<Payment>> execute(String token) {
    return repository.getUserPayments(token);
  }
}
