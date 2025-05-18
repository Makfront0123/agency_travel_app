import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class VerifyAccount {
  final AuthRepository repository;

  VerifyAccount(this.repository);

  Future<String> call(String otp, String email) {
    return repository.verify(email, otp);
  }
}
