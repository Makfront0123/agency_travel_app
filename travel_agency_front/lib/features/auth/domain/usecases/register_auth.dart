import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(String name, String lastName, email, String password,
      String confirmPassword) {
    return repository.register(
        name, lastName, email, password, confirmPassword);
  }
}
