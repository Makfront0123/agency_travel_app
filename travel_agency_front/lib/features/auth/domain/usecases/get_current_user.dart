import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<User> call(String token) {
    return repository.getCurrentUser(token);
  }
}
