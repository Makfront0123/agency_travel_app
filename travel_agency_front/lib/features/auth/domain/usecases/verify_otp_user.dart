import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class VerifyAccount {
  final AuthRepository repository;

  VerifyAccount(this.repository);

  Future<Map<String, dynamic>> call(String email, String otp) {
    return repository.verify(email, otp);
  }
}
