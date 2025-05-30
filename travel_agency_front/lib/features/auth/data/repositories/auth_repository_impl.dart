import 'package:travel_agency_front/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService authApiService;

  AuthRepositoryImpl(this.authApiService);

  @override
  Future<User> login(String email, String password) async {
    final userModel = await authApiService.login(email, password);
    return userModel;
  }

  @override
  Future<User> loginWithToken(String token) async {
    final userModel = await authApiService.getCurrentUser(token);
    return userModel;
  }

  @override
  Future<User> register(String name, String lastName, String email,
      String password, String confirmPassword) async {
    final userModel = await authApiService.register(
        name, lastName, email, password, confirmPassword);
    return userModel;
  }

  @override
  Future<Map<String, dynamic>> resendOtp(String email) async {
    return await authApiService.resendOtp(email);
  }

  @override
  Future<Map<String, dynamic>> resendForgotPasswordOtp(String email) async {
    return await authApiService.resendForgotPasswordOtp(email);
  }

  @override
  Future<void> logout() async {
    return await authApiService.logout();
  }

  @override
  Future<Map<String, dynamic>> verify(String email, String otp) async {
    return await authApiService.verify(email, otp);
  }

  @override
  Future<Map<String, dynamic>> verifyForgot(String email, String otp) async {
    return await authApiService.verifyForgot(email, otp);
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    return await authApiService.forgotPassword(email);
  }

  @override
  Future<Map<String, dynamic>> resetPassword(
      String email, String password, String newPassword) async {
    return await authApiService.resetPassword(email, password, newPassword);
  }

  @override
  Future<User> getCurrentUser(String token) async {
    return await authApiService.getCurrentUser(token);
  }
}
