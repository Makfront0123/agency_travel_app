import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository _repository;

  LoginUser(this._repository);

  Future<User> call(String email, String password) {
    return _repository.login(email, password);
  }

  Future<User> autoLoginWithToken(String token) {
    return _repository.getCurrentUser(token);
  }
}
