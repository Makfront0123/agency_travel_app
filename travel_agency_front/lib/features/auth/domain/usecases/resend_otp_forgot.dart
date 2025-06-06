import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpForgot {
  final AuthRepository repository;

  ResendOtpForgot(this.repository);

  Future<Map<String, dynamic>> call(String email) {
    return repository.resendForgotPasswordOtp(email);
  }
}
