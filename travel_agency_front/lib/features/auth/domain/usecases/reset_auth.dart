import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class ResetAuth {
  final AuthRepository repository;

  ResetAuth(this.repository);

  Future<Map<String, dynamic>> call(
    String email,
    String password,
    String newPassword,
  ) {
    return repository.resetPassword(
      email,
      password,
      newPassword,
    );
  }
}
